import 'package:flutter/material.dart';

//single instance of notice object
class NoticeDetailRoute extends StatefulWidget {
  const NoticeDetailRoute({Key? key}) : super(key: key);

  @override
  NoticeDetailRouteState createState() => NoticeDetailRouteState();
}

class NoticeDetailRouteState extends State<NoticeDetailRoute> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: (Text('공지목록보기')),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: ListTile(
                  leading: Icon(Icons.menu),
                  title: Text(
                    '6월 생일잔치 세부사항',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '2021년 6월 30일, 박강두 전도사',
                    style: TextStyle(fontSize: 10),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Text(
                '6월 생일자 : 김세희, 박효인, 최다운 \n준비팀 : 고은혜T, 고은미T, 박한동T \n\n 준비 열심히 해서 재밌게 진행해봅시다! 각 반의 선생님들께서는 아이들에게 생일잔치에 대한 문자 메세지를 하루 전 날에 꼬옥 보내주세요!\n\n**공지를 확인하신 선생님들은 댓글창에 "확인완료" 혹은 "확인했습니다"라고 댓글 부탁드려요~',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4.0),
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
            Container(
              color: Colors.white38,
              child: ListTile(
                  //CircleAvatar() , use images from the images folder
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text(
                    '김은희(소망반)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    '확인완료했습니다! 이번에도 즐겁게!',
                    style: TextStyle(fontSize: 13),
                  )),
            ),
            Container(
              color: Colors.white38,
              child: ListTile(
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text(
                    '박세미(다윗반)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    '확인완료했습니다ㅋㅋ 중등부도 그런 재미난 행사들을 많이 했으면 좋겠네요 ~~, 쩝..',
                    style: TextStyle(fontSize: 13),
                  )),
            ),
            Container(
              color: Colors.white38,
              child: ListTile(
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text(
                    '고은미(사랑반)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    '확인완료했습니다! 늘 신경써주셔서 감사해요!',
                    style: TextStyle(fontSize: 13),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
