import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/comment.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/screens/notice_new.dart';
import 'package:do_it_church/constants.dart';
import 'package:flutter/material.dart';
import 'notice_new.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

Notice notice = Notice();
Comment comment = Comment();

class NoticeDetail extends StatefulWidget {
  NoticeDetail({required this.noticeId});
  final noticeId;
  @override
  NoticeDetailState createState() => NoticeDetailState();
}

class NoticeDetailState extends State<NoticeDetail> {
  late TextEditingController commentTextController = TextEditingController();

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print(
            'SUCCESS(notice_detail_screen): Signed in As:${loggedInUser.uid}');
      }
    } catch (e) {
      print(e);
    }
  }

  void assignCurrentWriter() async {
    final user = _auth.currentUser;
    if (user != null) {
      User loggedInUser = user;
      print(
          'SUCCESS(notice_new_screen): Signed in As:${loggedInUser.phoneNumber}');
      comment.writer = loggedInUser.phoneNumber;
      print('(notice_new_screen): Signed User UID:${loggedInUser.uid}');
      QuerySnapshot userData = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: loggedInUser.uid)
          .get();
      for (var doc in userData.docs) {
        if (doc.exists) {
          //print('Data:${doc.data()}');
          print('(notice_detail): Signed User Name:${doc["name"]}');
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
        print('got noticeId');
        DocumentReference doc = firestore.collection("Notice").doc(widget.noticeId);
        await doc.get()
            .then((DocumentSnapshot doc) {
              setState(() {
                notice.title = doc.get("title").toString();
                notice.date = doc.get("date").toString();
                notice.writer = doc.get("writer").toString();
                notice.contents = doc.get("contents").toString();
              });
        });
      }
      // print('${notice.title}');
      // print('${notice.writer}');
      // print('${notice.contents}');
      // print('fetched notice details');
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    assignCurrentWriter();
    print(widget.noticeId);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getNoticeDetail(notice);
    });

    return MaterialApp(
      title: 'notice detail',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            '공지사항',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              }),
          leadingWidth: 20,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.create_rounded,
                  color: Color(0xFF89A1F8),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoticeAddRoute()),
                  );
                  setState(() {});
                }),
          ],
        ),
        body: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xffE5E5E5),
                width: 4.0,
              ),
            ),
          ),
          //width: size,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: NoticeDetailBuilder(
                      noticeId: widget.noticeId,
                      title: notice.title,
                      writer: notice.writer,
                      date: notice.date,
                      contents: notice.contents
                  ),
                ),

                //구분선 만들기
                Container(
                  height: 1.0,
                  width: 500.0,
                  color: Colors.black38,
                ),

                //댓글창 만들기
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: [
                    Expanded(
                      child: TextField(
                        //style:TextStyle(height:0.01, fontSize: 12),
                        controller: commentTextController,
                        decoration: InputDecoration(hintText: "댓글 입력창"),
                        //onSubmitted: _handleSubmitted(),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Color(0xFF89A1F8),
                      ),
                      onPressed: () {
                        _handleSubmitted(
                            commentTextController.text, widget.noticeId);
                        commentTextController.clear();
                      },
                      child: Text("완료"),
                    ),
                  ]),
                ),
                CommentBubble(noticeId: widget.noticeId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentBubble extends StatelessWidget {
  const CommentBubble({this.noticeId});
  final noticeId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("Notice").doc(noticeId).collection("Comments").snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return SizedBox(
            height: 400,
            child: ListView(
              children: (snapshot.data!).docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['comment']),
                  subtitle: Text(data['writer']),
                );
              }).toList(),
            ),
          );
        }
      );
  }
}

class NoticeDetailBuilder extends StatelessWidget {
  const NoticeDetailBuilder(
      {this.noticeId, this.title, this.writer, this.date, this.contents});
  final noticeId;
  final title;
  final writer;
  final date;
  final contents;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.notes_rounded,
                      color: Colors.black,
                    ),
                    trailing: IconButton(
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.more_horiz, color: Colors.black),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text('글 수정하기'),
                                  ),
                                  ListTile(
                                    title: Text('공유하기'),
                                  ),
                                  ListTile(
                                    title: Text('삭제하기'),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                    title: Text(
                      '$title',
                      style: kNoticeTitleTextStyle,
                    ),
                    subtitle: Text(
                      '$writer',
                      style: kNoticeSubTitleTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('$contents',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: kNoticeContentTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}

void _handleSubmitted(String commentText, String noticeId) async {
  print(noticeId);
  print(commentText);
  print(comment.writer);
  await firestore
      .collection('Notice')
      .doc(noticeId)
      .collection('Comments')
      .add({'comment': commentText, 'writer': comment.writer});
  //  _textEditingController.clear();
}

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
