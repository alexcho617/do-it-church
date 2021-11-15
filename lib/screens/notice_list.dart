import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/NoticeHeader.dart';
import 'package:do_it_church/components/NoticeListContents.dart';
import 'package:do_it_church/components/NoticeStatus.dart';
import 'package:do_it_church/components/ScreenDivider.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/screens/notice_detail.dart';
import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/notice_new.dart';
import 'package:do_it_church/services/myfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'notice_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:like_button/like_button.dart';

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
Notice notice = Notice();
final user = _auth.currentUser;

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
          notice.likeCount = doc.get("likeCount");
          notice.likedUsers = doc.get("likedUsers");
          print(notice.likedUsers);
          final noticeObject = NoticeBuilder(
            docId: notice.docId,
            title: notice.title,
            date: notice.date,
            writer: notice.writer,
            contents: notice.contents,
            commentCount: notice.commentCount ?? 0,
            likeCount: notice.likedUsers.length ?? 0,
            isLiked: notice.likedUsers.contains(user!.uid),
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

class NoticeBuilder extends StatefulWidget {
  NoticeBuilder(
      {this.title,
      this.date,
      this.writer,
      this.contents,
      this.docId,
      this.commentCount,
      this.likeCount,
      required this.isLiked});
  final title;
  final date;
  final contents;
  final writer;
  final docId;
  final commentCount;
  dynamic likeCount;
  bool isLiked;

  @override
  State<NoticeBuilder> createState() => _NoticeBuilderState();
}

class _NoticeBuilderState extends State<NoticeBuilder> {
  final user = _auth.currentUser;
  late dynamic likeCount;
  late bool isLiked;
  @override
  void initState() {
    super.initState();
    likeCount = widget.likeCount;
    isLiked = widget.isLiked;
  }

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
                docId: widget.docId,
                title: widget.title,
                writer: widget.writer,
                date: widget.date,
              ),
              NoticeListContents(contents: widget.contents),
              NoticeStatus(
                commentCounts: widget.commentCount.toString(),
                likeCount: widget.likeCount.toString(),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      //ElevatedButton, OutlinedButton
                      child: SizedBox(
                        height: 27,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero),
                          onPressed: () async {},
                          child: LikeButton(
                            //TODO INITLA LIKE STATE
                            isLiked: isLiked,
                            likeCount: likeCount,
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
                              print('onTap$isLiked');

                              setState(() {
                                if (isLiked == false) {
                                  isLiked = true;
                                  // likeCount++;

                                  addLikedList(
                                      _auth.currentUser!.uid, widget.docId);
                                } else {
                                  //already liked
                                  //FUNCTION DISABLED FOR EXAM
                                  isLiked = false;
                                  // likeCount--;
                                  removeLikedList(
                                      _auth.currentUser!.uid, widget.docId);
                                }
                                print('onTap$isLiked');
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 27,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoticeDetail(
                                          noticeId: '${widget.docId}',
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
