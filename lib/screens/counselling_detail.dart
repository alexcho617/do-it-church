import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/counselling.dart';
import 'package:do_it_church/screens/member_info_detail_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class CounsellingDetail extends StatefulWidget {
  CounsellingDetail({required this.docId});
  final docId;

  @override
  CounsellingDetailState createState() => CounsellingDetailState();
}

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

Counselling counselling = Counselling();
double deviceHeight = 0.0;
double deviceWidth = 0.0;

class CounsellingDetailState extends State<CounsellingDetail> {
  late TextEditingController commentTextController = TextEditingController();

  Future<void> getCounsellingDetail(Counselling counselling) async {
    try {
      //its missing the await
      if (widget.docId != null) {
        DocumentReference doc = firestore.collection("Counselling").doc(widget.docId);
        await doc.get().then((DocumentSnapshot doc) {
          setState(() {
            DateTime counsellingDate =
            DateTime.parse(doc.get("date").toDate().toString());
            counselling.date =
            '${counsellingDate.year}년 ${counsellingDate.month}월 ${counsellingDate.day}일';

            counselling.title = doc.get("title").toString();
            counselling.writer = doc.get("writer").toString();
            counselling.contents = doc.get("contents").toString();

          });
          return 0;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCounsellingDetail(counselling);
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Text('심방 세부내용', style: kAppBarTitleTextStyle),
    ),
    body: SafeArea(
      child: Container(
        child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                child: CounsellingBuilder(
                  docId: widget.docId,
                  title: counselling.title,
                  writer: counselling.writer,
                  date: counselling.date,
                  contents: counselling.contents
    ),
    ),

      ],
          ),
    ),
    ),),
    );
  }
}