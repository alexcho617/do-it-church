import 'package:do_it_church/screens/login.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MypageRoute extends StatefulWidget {
  @override
  _MypageRouteState createState() => _MypageRouteState();
}

class _MypageRouteState extends State<MypageRoute> {
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print(
            'SUCCESS(mypage_screen): Signed in As:${loggedInUser.phoneNumber}');
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
          '마이페이지',
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
              onPressed: null),
        ],
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: OutlinedButton(
              onPressed: () async {
                await _auth.signOut();
                print('SUCCESS(mypage_screen): Signed out');
                Navigator.popUntil(
                    context, (Route<dynamic> route) => route.isFirst);

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginRoute()));
              },
              child: Text('로그아웃'),
            ),
          )
        ]),
      ),
    );
  }
}
