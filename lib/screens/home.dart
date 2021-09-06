import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/NoticeHomeHeader.dart';
import 'package:do_it_church/components/NoticeHomeStatus.dart';
import 'package:do_it_church/components/NoticeListContents.dart';
import 'package:do_it_church/components/NoticeStatus.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:do_it_church/components/myPage.dart';
import 'package:like_button/like_button.dart';
import 'notice_detail.dart';
import 'notice_list.dart';
import 'mypage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
Notice notice = Notice();


class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {

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
    var mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '',
        ),
        //leading: Icon(Icons.people)
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MypageRoute()),
                );
                setState(() {});
              },
              )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                TextButton(onPressed: null, child: Text('출결관리')),
                TextButton(onPressed: null, child: Text('교적관리'))
              ],
            ),
            Container(
              width: size*0.93,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                  onPressed: () {},
                    child: Text('출결관리',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoticeListRoute()),
                      );
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Text(
                          '더보기',
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              width: size*0.93,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(1, 1), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Text('반 출석률 (월간)', style: TextStyle(color: Colors.black, fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                  VerticalDivider(thickness: 2, indent: 10, endIndent: 10,),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text('반 출결 (주간)', style: TextStyle(color: Colors.black, fontSize: 15))
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
            Container(height: 20,),
            Container(
              width: size*0.93,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                  onPressed: () {},
                  child: Text('공지사항',
                  ),
                ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoticeListRoute()),
                      );
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Text(
                          '더보기',
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                NoticeHomeStream()
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: myPageSlide(),
      )
    );
  }
}

class NoticeHomeStream extends StatelessWidget {
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

        DateTime noticeDate =
          DateTime.parse(docs.first.get("date").toDate().toString());
          notice.date =
          '${noticeDate.year}년 ${noticeDate.month}월 ${noticeDate.day}일';

          notice.docId = docs.first.id;
          notice.title = docs.first.get("title").toString();
          notice.writer = docs.first.get("writer").toString();
          notice.contents = docs.first.get("contents").toString();
          notice.commentCount = docs.first.get("commentCount");
          final noticeObject = NoticeBuilder(
            docId: notice.docId,
            title: notice.title,
            date: notice.date,
            writer: notice.writer,
            contents: notice.contents,
            commentCount: notice.commentCount ?? 0,
          );
        return Container(
          child: noticeObject,
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
    var mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size.width;
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoticeDetail(
                      noticeId: '$docId',
                    )));
          },
          child: Container(
            width: size*0.93,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(1, 1), // Shadow position
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NoticeHomeHeader(
                  docId: docId,
                  title: title,
                  writer: writer,
                  date: date,
                ),
                NoticeListContents(contents: contents),
                NoticeHomeStatus(commentCounts: commentCount.toString()),
                Container(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}