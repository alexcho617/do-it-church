import 'package:do_it_church/components/MemberCategory.dart';
import 'package:do_it_church/components/MembersList.dart';
import 'package:do_it_church/components/MembersListS.dart';
import 'package:do_it_church/components/NoticeSnackBar.dart';
import 'package:do_it_church/components/customUser.dart';
import 'package:do_it_church/components/teacher.dart';
import 'package:do_it_church/components/teacherRepository.dart';
import 'package:do_it_church/screens/notice_detail.dart';
import 'package:flutter/material.dart';
import 'package:do_it_church/screens/member_info_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../constants.dart';
import 'landing_route.dart';

class MemberInfoRoute extends StatefulWidget {
  const MemberInfoRoute({Key? key}) : super(key: key);
  @override
  _MemberInfoRouteState createState() => _MemberInfoRouteState();
}

class _MemberInfoRouteState extends State<MemberInfoRoute> {
  int selectedIndex = 0;
  final List<String> categories = ['전체보기', '교사', '학생'];
  final List<Teacher> allTeacherInformation = allTeachers;

  @override
  void initState() {
    super.initState();
    print(allTeacherInformation[0].address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('교적관리', style: kAppBarTitleTextStyle),
      ),

      body: Column(
        children: [
          //이름 검색창입니다.
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextField(
                decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              filled: true,
              fillColor: Color(0xFFF6F8FE),
              suffixIcon:
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              hintText: '이름을 검색하세요.',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            )),
          ),

          SizedBox(
            width: deviceWidth,
          ),

          CategorySelector(),

          Container(
            height: 500,
            width: 360,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: Column(
              children: [MembersList(), MembersListS()],
            ),
          ),
        ],
      ),

      //오른쪽 하단 버튼
      floatingActionButton: SpeedDial(
        // both default to 16
        // marginRight: 18,
        // marginBottom: 20,
        animatedIcon: AnimatedIcons.ellipsis_search,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.grey,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Color(0xFF89A1F8),
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.create),
              backgroundColor: Color(0xFF89A1F8),
              label: '추가하기',
              labelStyle: TextStyle(fontSize: 15.0),
              onTap: () => print('추가')),
          SpeedDialChild(
            child: Icon(Icons.delete),
            backgroundColor: Colors.white,
            label: '삭제하기',
            labelStyle: TextStyle(fontSize: 15.0),
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text("해당정보 삭제하기"),
                      content: Text('정말로 삭제하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            Navigator.pop(context);
                            NoticeSnackBar.show(context, '해당 교적정보가 삭제 되었습니다.');
                          },
                          child: Text('OK'),
                        ),
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}
