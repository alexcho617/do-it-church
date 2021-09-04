import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/NoticeHeader.dart';
import 'package:do_it_church/components/NoticeListContents.dart';
import 'package:do_it_church/components/NoticeStatus.dart';
import 'package:do_it_church/components/ScreenDivider.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/screens/notice_detail.dart';
import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/notice_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'notice_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:like_button/like_button.dart';

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
Notice notice = Notice();

class NoticeListRoute extends StatefulWidget {
  @override
  _NoticeListRouteState createState() => _NoticeListRouteState();
}

class _NoticeListRouteState extends State<NoticeListRoute> {
  //User loggedInUser; //getting error
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print(
            'SUCCESS(notice_list_screen): Signed in As:${loggedInUser.phoneNumber}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '공지목록',
          style: kAppBarTitleTextStyle,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            NoticeStream(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoticeAddRoute()),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Color(0xFF89A1F8),
      ),
    );
  }
}

class NoticeStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('Notice')
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final docs = (snapshot.data!).docs;

        List<NoticeBuilder> noticeList = [];

        for (var doc in docs) {
          DateTime noticeDate =
              DateTime.parse(doc.get("date").toDate().toString());
          notice.date =
              '${noticeDate.year}년 ${noticeDate.month}월 ${noticeDate.day}일';

          notice.docId = doc.id;
          notice.title = doc.get("title").toString();
          notice.writer = doc.get("writer").toString();
          notice.contents = doc.get("contents").toString();
          notice.commentCount = doc.get("commentCount");

          final noticeObject = NoticeBuilder(
            docId: notice.docId,
            title: notice.title,
            date: notice.date,
            writer: notice.writer,
            contents: notice.contents,
            commentCount: notice.commentCount ?? 0,
          );

          noticeList.add(noticeObject);
        }
        return Expanded(
          child: ListView(
            children: noticeList,
          ),
        );
      },
    );
  }
}

class NoticeBuilder extends StatelessWidget {
  const NoticeBuilder(
      {this.title,
      this.date,
      this.writer,
      this.contents,
      this.docId,
      this.commentCount});

  final title;
  final date;
  final contents;
  final writer;
  final docId;
  final commentCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //width: ,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NoticeHeader(
                docId: docId,
                title: title,
                writer: writer,
                date: date,
              ),
              NoticeListContents(contents: contents),
              NoticeStatus(commentCounts: commentCount.toString()),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      //likebutton
                      //ElevatedButton, OutlinedButton
                      child: SizedBox(
                        height: 27,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero),
                          onPressed: () async {},
                          child: LikeButton(
                            isLiked: false,
                            likeCount: 5,
                            likeBuilder: (isLiked) {
                              final color = isLiked ? Colors.red : Colors.grey;
                              return Icon(Icons.favorite,
                                  color: color, size: 13);
                            },
                            likeCountPadding: EdgeInsets.zero,
                            countBuilder: (count, isLiked, text) {
                              final color =
                                  isLiked ? Color(0xFF89A1F8) : Colors.grey;
                              return Text(
                                text,
                                style: TextStyle(fontSize: 13, color: color),
                              );
                            },
                            onTap: (isLiked) async {
                              isLiked = !isLiked;
                              //likeCount += isLiked ? 1 : -1;
                              return isLiked;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      //comment button
                      child: SizedBox(
                        height: 27,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoticeDetail(
                                          noticeId: '$docId',
                                        )));
                          },
                          child: Text('댓글쓰기', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
            ],
          ),
        ),
        ScreenDivider(
          color: Color(0xFFE0E0E0),
          thickness: 2,
        ),
      ],
    );
  }
}
