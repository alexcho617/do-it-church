import 'package:do_it_church/components/MemberCategory.dart';
import 'package:do_it_church/components/MembersList.dart';
import 'package:do_it_church/components/MembersListDetail.dart';
import 'package:do_it_church/components/NoticeSnackBar.dart';
import 'package:do_it_church/components/ScreenDivider.dart';
import 'package:do_it_church/components/customUser.dart';
import 'package:do_it_church/screens/notice_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';


//TEACHER IMPORTS
import '../components/teacherRepository.dart';
import 'package:do_it_church/components/teacher.dart';

class MemberInfoDetailRoute extends StatefulWidget {
  const MemberInfoDetailRoute({Key? key}) : super(key: key);
  @override
  _MemberInfoDetailRouteState createState() => _MemberInfoDetailRouteState();
}

class _MemberInfoDetailRouteState extends State<MemberInfoDetailRoute> {
  int selectedIndex = 0;
  final List<String> categories = ['전체보기', '교사', '학생'];
   final List<Teacher> allTeacherInformation = allTeachers;

   @override
   void initState() {
     super.initState();
     print(allTeacherInformation[0]);
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('교적관리정보', style: kAppBarTitleTextStyle),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 120,
                color: Color(0xFFF6F8FE),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MembersListDetail(),
                  ],
                ),
              ),
              Container(
                height: 30,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xFFD7D7D7))),
                height: 40,
                width: 350,
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      color: Color(0xFFF6F8FE),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text('생년월일')),
                        ],
                      ),
                    ),
                    Text(
                        '${allTeacherInformation[0].birthdate}',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xFFD7D7D7))),
                height: 40,
                width: 350,
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      color: Color(0xFFF6F8FE),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text('등록일')),
                        ],
                      ),
                    ),
                    Text(
                      ' 2018.05.18',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xFFD7D7D7))),
                height: 40,
                width: 350,
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      color: Color(0xFFF6F8FE),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text('담당반')),
                        ],
                      ),
                    ),
                    Text(
                      ' 사랑반',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              Container(
                height: 30,
              ),
              ScreenDivider(color: Color(0xFFD7D7D7), thickness: 1),
              Container(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    color: Color(0xFFF6F8FE),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('주소')),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD7D7D7))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 경기도 수원시 권선구',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    color: Color(0xFFF6F8FE),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('가족관계')),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD7D7D7))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 배우지: 박서준 집사 / 자녀: 박아람, 박사랑',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    color: Color(0xFFF6F8FE),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('소속 및 구분')),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD7D7D7))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 제 1교구 기쁨셀 / 집사',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
