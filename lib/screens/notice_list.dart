import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/notice_detail.dart';
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
      backgroundColor: Colors.white,
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
      body: Center(
        child: Column(
          children: <Widget>[
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => NoticeDetail()),
            //     );
            //     setState(() {});
            //     },
            NoticeStream(),
          ],
        ),
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
        //(snapshot.data!).docs.map((DocumentSnapshot document)
        List<NoticeBuilder> noticeList = [];

        for (var doc in docs) {
          notice.docId = doc.id;
          print(notice.docId);
          notice.title = doc.get("title").toString();
          notice.date = doc.get("date").toString();
          notice.writer = doc.get("writer").toString();
          notice.contents = doc.get("contents").toString();
          final noticeObject = NoticeBuilder(
            title: notice.title,
            date: notice.date,
            writer: notice.writer,
            contents: notice.contents,
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
      {this.title, this.date, this.writer, this.contents, this.docId});
  final title;
  final date;
  final contents;
  final writer;
  final docId;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    title: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoticeDetail(
                                      notice: notice,
                                    )));
                      },
                      style:
                          TextButton.styleFrom(alignment: Alignment.centerLeft),
                      child: Text(
                        '$title',
                        style: kNoticeTitleTextStyle,
                      ),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              text: TextSpan(text: '$contents', style: kNoticeContentTextStyle),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.remove_red_eye_outlined,
                  size: 12,
                  color: Colors.grey,
                ),
                Container(
                  width: 5,
                ),
                Text('25', style: kNoticeCountTextStyle),
                Container(
                  width: 10,
                ),
                Icon(Icons.chat_outlined, size: 12, color: Colors.grey),
                Container(
                  width: 5,
                ),
                Text('10', style: kNoticeCountTextStyle)
              ],
            ),
          ),
          Container(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  //ElevatedButton, OutlinedButton
                  child: SizedBox(
                    height: 27,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () async {},
                      child: LikeButton(
                        isLiked: false,
                        likeCount: 17,
                        likeBuilder: (isLiked) {
                          final color = isLiked ? Colors.red : Colors.grey;
                          return Icon(Icons.favorite, color: color, size: 13);
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
                          return !isLiked;
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
                      onPressed: () {},
                      child: Text('댓글쓰기', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 20,
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
