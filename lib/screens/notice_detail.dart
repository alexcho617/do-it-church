import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/NoticeDetailHeader.dart';
import 'package:do_it_church/components/NoticeDetailStatus.dart';
import 'package:do_it_church/components/ScreenDivider.dart';
import 'package:do_it_church/components/comment.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void _handleSubmitted(String commentText, String noticeId) async {
  print(noticeId);
  print(commentText);
  print(comment.writer);
  await firestore
      .collection('Notice')
      .doc(noticeId)
      .collection('Comments')
      .add({
    'comment': commentText,
    'writer': comment.writer,
    'date': Timestamp.now()
  });
}

// void getUserCommentCount() async {
//   bool commented = Comments[comment] == true;
//   if (commented) {
//     stream: firestore
//         .collection("Notice")
//         .doc(noticeId)
//         .collection("Comments")
//         .updateData({"commented.$currentOnlineUserId": true});
//
//     setState(() {
//       //print(commentCount);
//       commentCount = commentCount + 1;
//       commented = true;
//       comments[currentOnlineUserId] = true;
//     });
//   }
// }

void showAlertDialog(BuildContext context) async {
  String result = await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('삭제하기'),
        content: Text("글을 삭제하시겠습니까?"),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            onPressed: () {
              Navigator.pop(context, "OK");
            },
          ),
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.pop(context, "Cancel");
            },
          ),
        ],
      );
    },
  );
}

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

Notice notice = Notice();
Comment comment = Comment();

double deviceHeight = 0.0;
double deviceWidth = 0.0;

class NoticeDetail extends StatefulWidget {
  NoticeDetail({required this.noticeId});
  final noticeId;

  @override
  NoticeDetailState createState() => NoticeDetailState();
}

class NoticeDetailState extends State<NoticeDetail> {
  late TextEditingController commentTextController = TextEditingController();

  void assignCommentWriter() async {
    final user = _auth.currentUser;
    if (user != null) {
      User loggedInUser = user;
      QuerySnapshot userData = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: loggedInUser.uid)
          .get();
      for (var doc in userData.docs) {
        if (doc.exists) {
          comment.writer = doc["name"];
        } else {
          print('noData');
        }
      }
    }
  }

  Future<void> getNoticeDetail(Notice notice) async {
    try {
      //its missing the await
      if (widget.noticeId != null) {
        DocumentReference doc =
            firestore.collection("Notice").doc(widget.noticeId);
        await doc.get().then((DocumentSnapshot doc) {
          setState(() {
            notice.title = doc.get("title").toString();
            notice.date = doc.get("date").toString();
            notice.writer = doc.get("writer").toString();
            notice.contents = doc.get("contents").toString();
          });
          return 0;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    assignCommentWriter();
    getNoticeDetail(notice);
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('공지사항', style: kAppBarTitleTextStyle),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  child: NoticeDetailBuilder(
                      docId: widget.noticeId,
                      title: notice.title,
                      writer: notice.writer,
                      date: notice.date,
                      contents: notice.contents
                  ),
                ),
                ScreenDivider(
                  color: Colors.grey,
                  thickness: 2.5,
                ),
                Container(
                    child: CommentBubble(noticeId: widget.noticeId, commentsCount: notice.comments,)
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(children: [
                    Expanded(
                      child: TextField(
                        controller: commentTextController,
                        decoration: InputDecoration(hintText: "댓글을 입력하세요"),
                        maxLines: null,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                      ),
                      onPressed: () {
                        if (commentTextController.text != '') {
                          _handleSubmitted(
                              commentTextController.text, widget.noticeId);
                          commentTextController.clear();
                        }
                      },
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoticeDetailBuilder extends StatelessWidget {
  const NoticeDetailBuilder(
      {this.docId, this.title, this.writer, this.date, this.contents});

  final docId;
  final title;
  final writer;
  final date;
  final contents;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NoticeDetailHeader(docId: docId, title: title, writer: writer),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  text: TextSpan(
                      text: '$contents', style: kNoticeContentTextStyle),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ), //댓글읽은사람, 하트
          NoticeDetailStatus(),
        ],
      ),
    );
  }
}

class CommentBubble extends StatelessWidget {
  const CommentBubble({this.noticeId, this.commentsCount});
  final noticeId;
  final commentsCount;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("Notice")
            .doc(noticeId)
            .collection("Comments")
            .orderBy(
              "date",
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return SizedBox(
            height: deviceHeight * 0.3,
            child: ListView(
              children: (snapshot.data!).docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                //data.length = commentsCount;
                return Column(
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      //TODO 2: Get Image from server
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'images/logo.jpg'), //always add images in directory
                        radius: 20,
                      ),
                      title: Text(
                        data['writer'],
                        style: kListTileTitleTextStyle,
                      ),
                      subtitle: Text(
                        data['comment'],
                        style: kListTileSubtitleTextStyle,
                      ),
                    ),
                    ScreenDivider(
                      color: Colors.black12,
                      thickness: 1,
                    )
                  ],
                );
              }).toList(),
            ),
          );
        });
  }
}
