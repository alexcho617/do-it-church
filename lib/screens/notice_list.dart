import 'package:flutter/material.dart';

class noticeListRoute extends StatefulWidget {
  @override
  _noticeListRouteState createState() => _noticeListRouteState();
}

class _noticeListRouteState extends State<noticeListRoute> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('뒤로가기',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded), onPressed: null),
        leadingWidth: 20,
        actions: [
          IconButton(icon: Icon(Icons.create_rounded, color: Colors.blueAccent,), onPressed: null),
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
              width: size,
              child:
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                          Icons.menu
                      ),
                      Expanded(
                          child:
                          Container(
                            child: Text(
                              '6월 생일잔치 세부사항',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            margin: const EdgeInsets.only(left: 10),
                          )
                      ),
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
                          '2021년 6월 30일, 박강두 전도사',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 35, bottom: 20),
                        child: Text(
                            '6월 생일자: 김세희, 박효인, 최다운'
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: OutlineButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.favorite, color: Colors.red,),
                          label: Text('10'),
                        ),
                        margin: const EdgeInsets.only(left: 10),
                      ),
                      Container(
                        child: OutlineButton(
                          onPressed: () {},
                          child:
                          Text('댓글쓰기'),
                        ),
                        margin: const EdgeInsets.only(left: 20),
                      ),
                      Container(
                        child: OutlineButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.share, color: Colors.blueAccent,),
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