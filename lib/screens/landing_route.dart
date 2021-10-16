import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:do_it_church/screens/home.dart';
import 'package:do_it_church/screens/chat.dart';
import 'guide.dart';
import 'more.dart';

class LandingRoute extends StatefulWidget {
  @override
  _LandingRouteState createState() => _LandingRouteState();
}

class _LandingRouteState extends State<LandingRoute> {
  int screenIndex = 0;
  final List<Widget> screenList = [
    HomeRoute(),
    ChatRoute(),
    GuideRoute(),
    MoreRoute()
  ];
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
        onTap: (value) {
          setState(() {
            screenIndex = value;
          });
        },
      ),
    );
  }
}
