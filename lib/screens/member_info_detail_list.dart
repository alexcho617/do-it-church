import 'package:do_it_church/components/MemberCategory.dart';
import 'package:do_it_church/components/MembersList.dart';
import 'package:do_it_church/components/MembersListDetail.dart';
import 'package:do_it_church/components/MembersListDetailS.dart';
import 'package:do_it_church/components/NoticeSnackBar.dart';
import 'package:do_it_church/components/ScreenDivider.dart';
import 'package:do_it_church/components/customUser.dart';
import 'package:do_it_church/screens/notice_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../constants.dart';
import 'landing_route.dart';

class MemberInfoDetailListRoute extends StatefulWidget {
  const MemberInfoDetailListRoute({Key? key}) : super(key: key);
  @override
  _MemberInfoDetailListRouteState createState() => _MemberInfoDetailListRouteState();
}

class _MemberInfoDetailListRouteState extends State<MemberInfoDetailListRoute> {
  int selectedIndex = 0;
  final List<String> categories = ['전체보기', '교사', '학생'];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('심방정보', style: kAppBarTitleTextStyle),
      ),

      body: ListView(
        children: [
          Column(
            children: [

            ],
          ),
        ],
      ),
    );
  }
}
