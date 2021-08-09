import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoticeAddRoute extends StatefulWidget {
  @override
  _NoticeAddRouteState createState() => _NoticeAddRouteState();
}

class _NoticeAddRouteState extends State<NoticeAddRoute> {
  final _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print(
            'SUCCESS(notice_new_screen): Signed in As:${loggedInUser.phoneNumber}');
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
  String noticeTitle = '';
  String noticeContents = '';
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    // final size = mediaQuery.size.width;
    int screenIndex = 0;
    List<Widget> screenList = [
      Text('홈스크린'),
      Text('채팅'),
      Text('활동가이드화면'),
      Text('모아보기화면')
    ];
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
              child: Text(
                '완료',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                print('New Notice Title = $noticeTitle');
                print('New Notice Contents = $noticeContents');
                Navigator.pop(context);
              }),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextField(
                  autocorrect: true,
                  onChanged: (value3) => noticeTitle = value3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '새로운 공지의 제목을 적어보세요',
                  ),
                ),
                Divider(),
                TextField(
                  onChanged: (value4) => noticeContents = value4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '여기를 눌러 새로운 공지를 적어보세요',
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
