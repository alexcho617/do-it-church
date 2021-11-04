import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/NoticeDetailHeader.dart';
import 'package:do_it_church/components/NoticeDetailStatus.dart';
import 'package:do_it_church/components/NoticeSnackBar.dart';
import 'package:do_it_church/components/ScreenDivider.dart';
import 'package:do_it_church/components/comment.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void _handleSubmitted(String commentText, String noticeId) async {
  print('NOTICE ID:$noticeId');
  print('COMMENT TEXT:$commentText');
  print('COMMENT WRITER:$comment.writer');
  //add comment to notice
  firestore.collection('Notice').doc(noticeId).collection('Comments').add({
    'comment': commentText,
    'writer': comment.writer,
    'date': Timestamp.now()
  });
  //update commentcount
  firestore
      .collection('Notice')
      .doc(noticeId)
      .update({'commentCount': globalCommentCount});
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

class NoticeDetailBuilder extends StatelessWidget {
  const NoticeDetailBuilder({
    this.docId,
    this.title,
    this.writer,
    this.date,
    this.contents,
  });
  final docId;
  final title;
  final writer;
  final date;
  final contents;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * 0.40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NoticeDetailHeader(
            docId: docId,
            title: title,
            writer: writer,
            date: date,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  maxLines: 6,
                  text: TextSpan(
                      text: '$contents', style: kNoticeDetailContentTextStyle),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ), //댓글읽은사람, 하트
        ],
      ),
    );
  }
}

class CommentBubble extends StatefulWidget {
  const CommentBubble({
    this.noticeId,
  });
  final noticeId;

  @override
  _CommentBubbleState createState() => _CommentBubbleState();
}

class _CommentBubbleState extends State<CommentBubble> {
  late ScrollController _scrollController;

  _scrollListener() async {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // top
    } else if (_scrollController.offset <=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // bottom
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("Notice")
            .doc(widget.noticeId)
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
              controller: _scrollController,
              children: (snapshot.data!).docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                });
                return Column(
                  children: [
                    ListTile(
                      onLongPress: (){
                        FirebaseFirestore.instance
                            .collection("Notice")
                            .doc(widget.noticeId).collection('Comments')
                            .doc(document.id)
                            .delete()
                            .then((value) {});
                        globalCommentCount -= 1;
                        FirebaseFirestore.instance.collection('Notice').doc(widget.noticeId).update({'commentCount': globalCommentCount});
                        NoticeSnackBar.show(context, '댓글이 삭제 되었습니다.');
                      },
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      //TODO 2: Get Image from server
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'images/logo.png'), //always add images in directory
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

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

Notice notice = Notice();
Comment comment = Comment();
int globalCommentCount = 0;
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

  Future<void> getNoticeDetail(Notice notice) async {
    try {
      //its missing the await
      if (widget.noticeId != null) {
        DocumentReference doc = firestore.collection("Notice").doc(widget.noticeId);
        await doc.get().then((DocumentSnapshot doc) {
          setState(() {
            DateTime noticeDate =
                DateTime.parse(doc.get("date").toDate().toString());
            notice.date =
                '${noticeDate.year}년 ${noticeDate.month}월 ${noticeDate.day}일';

            notice.title = doc.get("title").toString();
            notice.writer = doc.get("writer").toString();
            notice.contents = doc.get("contents").toString();
            notice.commentCount = doc.get("commentCount");
            globalCommentCount = notice.commentCount;
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
                Container(
                  child: NoticeDetailStatus(
                    commentCounts: globalCommentCount.toString(),
                    //commentCounts: globalCommentsCount.toString(),
                  ),
                ),
                ScreenDivider(
                  color: Colors.grey,
                  thickness: 2.5,
                ),
                Container(
                    child: CommentBubble(
                  noticeId: widget.noticeId,
                )),
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
                          setState(() {
                            globalCommentCount += 1;
                            print('GLOBAL COMMENT COUNT $globalCommentCount');
                          });
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
