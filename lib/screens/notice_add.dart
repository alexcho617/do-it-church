import 'package:flutter/material.dart';
import 'notice_list.dart';
import 'package:do_it_church/components/notice.dart';

class NoticeAddRoute extends StatefulWidget {
  @override
  _NoticeAddRouteState createState() => _NoticeAddRouteState();
}

class _NoticeAddRouteState extends State<NoticeAddRoute> {
  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    // final size = mediaQuery.size.width;
    int screenIndex = 0;
    List<Widget> screenList = [Text('홈스크린'), Text('채팅'), Text('활동가이드화면'), Text('모아보기화면')];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '공지작성',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                //
              });
            }),
        leadingWidth: 20,
        actions: [
          TextButton(
            child: Text('완료',
            style: TextStyle(color: Colors.red),),
              onPressed: null),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '여기를 눌러 새로운 공지를 적어보세요',

                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
