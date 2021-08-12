import 'package:do_it_church/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRoute extends StatefulWidget {
  @override
  _ChatRouteState createState() => _ChatRouteState();
}

class _ChatRouteState extends State<ChatRoute> {
  final _auth = FirebaseAuth.instance;

  //User loggedInUser; //getting error
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print('SUCCESS(chat_screen): Signed in As:${loggedInUser.phoneNumber}');
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
          '채팅',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        leadingWidth: 20,
      ),
      body: Center(
        child: Text('채팅 화면'),
      ),
    );
  }
}
