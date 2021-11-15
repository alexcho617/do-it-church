import 'package:do_it_church/components/CounsellingHeader.dart';
import 'package:do_it_church/components/CounsellingListContents.dart';
import 'package:do_it_church/components/MemberCategory.dart';
import 'package:do_it_church/components/MembersList.dart';
import 'package:do_it_church/components/MembersListDetail.dart';
import 'package:do_it_church/components/MembersListDetailS.dart';
import 'package:do_it_church/components/NoticeHeader.dart';
import 'package:do_it_church/components/NoticeSnackBar.dart';
import 'package:do_it_church/components/ScreenDivider.dart';
import 'package:do_it_church/components/counselling.dart';
import 'package:do_it_church/components/customUser.dart';
import 'package:do_it_church/components/student.dart';
import 'package:do_it_church/screens/notice_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../constants.dart';
import 'counselling_detail.dart';
import 'counselling_new.dart';
import 'landing_route.dart';

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
Counselling counselling = Counselling();

class MemberInfoDetailListRoute extends StatefulWidget {
  const MemberInfoDetailListRoute({Key? key}) : super(key: key);
  @override
  _MemberInfoDetailListRouteState createState() => _MemberInfoDetailListRouteState();
}

class _MemberInfoDetailListRouteState extends State<MemberInfoDetailListRoute> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('심방정보', style: kAppBarTitleTextStyle),
      ),

      body: Center(
        child: Column(
          children: <Widget>[
            CounsellingStream(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CounsellingAddRoute()),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Color(0xFF89A1F8),
      ),
    );
  }
}

class CounsellingStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('Counselling')
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final docs = (snapshot.data!).docs;

        List<CounsellingBuilder> counsellingList = [];
        for (var doc in docs) {
          DateTime counsellingDate =
          DateTime.parse(doc.get("date").toDate().toString());
          counselling.date =
          '${counsellingDate.year}년 ${counsellingDate.month}월 ${counsellingDate.day}일';

          counselling.docId = doc.id;
          counselling.title = doc.get("title").toString();
          counselling.writer = doc.get("writer").toString();
          counselling.contents = doc.get("contents").toString();

          final counsellingObject = CounsellingBuilder(
            docId: counselling.docId,
            title:counselling.title,
            date:counselling.date,
            writer: counselling.writer,
            contents: counselling.contents,
          );
          counsellingList.add(counsellingObject);
        }
        return Expanded(
          child: ListView(
            children: counsellingList,
          ),
        );
      },
    );
  }
}

class CounsellingBuilder extends StatelessWidget{
  const CounsellingBuilder(
      {this.title,
        this.date,
        this.writer,
        this.contents,
        this.docId,
        });
  final title;
  final date;
  final contents;
  final writer;
  final docId;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            //width: ,
            padding: EdgeInsets.symmetric(horizontal: 20),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              CounsellingHeader(
                docId: docId,
                title: title,
                writer: writer,
                date: date,
    ),
                CounsellingListContents(contents: contents),
                ScreenDivider(
                  color: Color(0xFFE0E0E0),
                  thickness: 2,
                ),
              ]
             ),
          ),
        ],
    );
  }
}



