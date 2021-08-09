import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/landing_route.dart';
import 'package:do_it_church/screens/notice_new.dart';
import 'package:flutter/material.dart';
import 'notice_detail.dart';
import 'notice_new.dart';
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
    // var mediaQuery = MediaQuery.of(context);
    // final size = mediaQuery.size.width;
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
              setState(() {
                //
              });
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoticeDetail()),
                );
                setState(() {});
              },
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20),
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
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.notes_rounded,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '6월 생일잔치 세부사항',
                                      style: kNoticeTitleTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      //날짜 + 작성자 서버에서 받아서 변수로 출력
                                      '2021년 6월 30일, 박강두 전도사',
                                      style: kNoticeSubTitleTextStyle,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      text: TextSpan(
                                          text:
                                              '6월 생일자: 김세희, 박효인, 최다운\n준비팀: 고은혜T, 고은미T, 박현동T\n'
                                              '준비 열심히 해서 재밌게 진행해봅시다! 각 반의 선생님들께서는 아이들에게 생일잔치에 대한 문자 메세지를 하루 전 날에 꼬옥 보내주세요!',
                                          style: kNoticeContentTextStyle),
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
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
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 12,
                          color: Colors.grey,
                        ),
                        Container(
                          width: 5,
                        ),
                        Text('10', style: kNoticeCountTextStyle),
                        Container(
                          width: 10,
                        ),
                        Icon(Icons.chat_outlined, size: 12, color: Colors.grey),
                        Container(
                          width: 5,
                        ),
                        Text('4', style: kNoticeCountTextStyle)
                      ],
                    ),
                    Container(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          //ElevatedButton, OutlinedButton
                          child: SizedBox(
                            height: 27,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 13,
                              ),
                              label: Text(
                                '10',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                        Container(
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
                                      builder: (context) => LandingRoute()),
                                );
                                setState(() {});
                              },
                              child:
                                  Text('댓글쓰기', style: TextStyle(fontSize: 13)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
