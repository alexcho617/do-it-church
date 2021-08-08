import 'package:do_it_church/screens/notice_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:do_it_church/screens/home.dart';
import 'chat.dart';
import 'guide.dart';
import 'more.dart';
import 'notice_list.dart';
import 'mypage.dart';
import 'package:do_it_church/components/notice.dart';

class MainRoute extends StatefulWidget {
  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  int screenIndex = 0;
  final List <Widget> screenList = [HomeRoute(), ChatRoute(), GuideRoute(), MoreRoute()];
  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    // final size = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: screenList[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass_rounded),
            label: '활동가이드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: '모아보기',
          ),
        ],
        currentIndex: screenIndex,
        selectedItemColor: Color(0xff89A1F8),
        unselectedItemColor: Color(0xffE5E5E5),
        onTap: (value){
          setState(() {
            screenIndex = value;
          });
        },
      ),
    );
  }
}
