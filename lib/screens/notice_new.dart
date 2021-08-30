import 'package:do_it_church/components/ScreenDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/constants.dart';

void _handleSubmitted(String titleText, String contentText) async {
  print(titleText);
  print(contentText);
  print(notice.writer);
  await firestore.collection('Notice').add({
    'title': titleText,
    'contents': contentText,
    'writer': notice.writer,
    //server
    'date': Timestamp.now(),
  });
}

Notice notice = Notice();
final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class NoticeAddRoute extends StatefulWidget {
  @override
  _NoticeAddRouteState createState() => _NoticeAddRouteState();
}

class _NoticeAddRouteState extends State<NoticeAddRoute> {
  void assignCurrentWriter() async {
    final user = _auth.currentUser;
    if (user != null) {
      User loggedInUser = user;
      print(
          'SUCCESS(notice_new_screen): Signed in As:${loggedInUser.phoneNumber}');
      notice.writer = loggedInUser.phoneNumber;
      print('(notice_new_screen): Signed User UID:${loggedInUser.uid}');
      QuerySnapshot userData = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: loggedInUser.uid)
          .get();
      for (var doc in userData.docs) {
        if (doc.exists) {
          //print('Data:${doc.data()}');
          print('(notice_new_screen): Signed User Name:${doc["name"]}');
          notice.writer = doc["name"];
        } else {
          print('noData');
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    assignCurrentWriter();
  }

  @override
  Widget build(BuildContext context) {
    final contentTextController = TextEditingController();
    final titleTextController = TextEditingController();
    final height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('공지작성', style: kAppBarTitleTextStyle),
        leading: IconButton(
            icon: Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          TextButton(
              child: Text('완료'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  _handleSubmitted(
                      titleTextController.text, contentTextController.text);
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '제목은 필수입니다';
                        }
                        return null;
                      },
                      controller: titleTextController,
                      decoration: InputDecoration(
                          hintText: "제목",
                          hintStyle: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '내용은 필수입니다';
                        }
                        return null;
                      },
                      controller: contentTextController,
                      decoration: InputDecoration(hintText: "내용을 입력하세요"),
                      maxLines: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
