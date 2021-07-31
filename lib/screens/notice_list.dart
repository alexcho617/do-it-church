import 'package:flutter/material.dart';
import 'notice_detail.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoticeListRoute extends StatefulWidget {
  @override
  _NoticeListRouteState createState() => _NoticeListRouteState();
}

class _NoticeListRouteState extends State<NoticeListRoute> {
  final _auth = FirebaseAuth.instance;
  //User loggedInUser; //getting error
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print('SUCCESS(notice_screen): Signed in As:${loggedInUser.email}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    // final size = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              _auth.signOut();
              print('SUCCESS(notice_screen): Sign Out');
              Navigator.pop(context);
              setState(() {
                //
              });
            }),
        leadingWidth: 20,
        actions: [
          IconButton(
              icon: Icon(
                Icons.create_rounded,
                color: Colors.blueAccent,
              ),
              onPressed: null),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 4.0,
                  ),
                ),
              ),
              //width: size,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.menu),
                      Expanded(
                          child: Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoticeDetailRoute()),
                            );
                            setState(() {
                              //
                            });
                          },
                          child: Text(
                            '6월 생일잔치 세부사항',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.only(left: 10),
                      )),
                      //TextButton
                      FlatButton(
                        onPressed: () {},
                        child: Text('수정하기'),
                        textColor: Colors.red,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 35),
                        child: Text(
                          //날짜 + 작성자 서버에서 받아서 변수로 출력
                          '2021년 6월 30일, 박강두 전도사',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20, left: 35, bottom: 20),
                        child: Text('6월 생일자: 김세희, 박효인, 최다운'),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        //ElevatedButton, OutlinedButton
                        child: OutlineButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          label: Text('10'),
                        ),
                        margin: const EdgeInsets.only(left: 10),
                      ),
                      Container(
                        child: OutlineButton(
                          onPressed: () {},
                          child: Text('댓글쓰기'),
                        ),
                        margin: const EdgeInsets.only(left: 20),
                      ),
                      Container(
                        child: OutlineButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: Colors.blueAccent,
                          ),
                          label: Text('공유하기'),
                        ),
                        margin: const EdgeInsets.only(left: 20),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
