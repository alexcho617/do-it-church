import 'package:do_it_church/components/NoticeSnackBar.dart';
import 'package:do_it_church/screens/home.dart';
import 'package:do_it_church/screens/notice_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/constants.dart';

class NoticeEditRoute extends StatefulWidget {
  NoticeEditRoute({required this.noticeId});
  final noticeId;

  @override
  _NoticeEditRouteState createState() => _NoticeEditRouteState();
}

Notice notice = Notice();
final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class _NoticeEditRouteState extends State<NoticeEditRoute> {
  final contentTextController = TextEditingController();
  final titleTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _handleSubmitted(String titleText, String contentText) async {
    await firestore
        .collection('Church')
        .doc(HomeRoute.currentChurchId)
        .collection('Notice')
        .doc(widget.noticeId)
        .update({
      'title': titleText,
      'contents': contentText,
    });
  }

  void getNoticeDetail(Notice notice) async {
    try {
      //its missing the await
      if (widget.noticeId != null) {
        DocumentReference doc = firestore
            .collection('Church')
            .doc(HomeRoute.currentChurchId)
            .collection("Notice")
            .doc(widget.noticeId);
        await doc.get().then((DocumentSnapshot doc) {
          setState(() {
            notice.title = doc.get("title").toString();
            notice.date = doc.get("date").toString();
            notice.writer = doc.get("writer").toString();
            notice.contents = doc.get("contents").toString();

            titleTextController.text = notice.title.toString();
            contentTextController.text = notice.contents.toString();
          });
          return 0;
        });
      }
    } catch (e) {
      print(e);
    }
  }

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
    getNoticeDetail(notice);
  }

  @override
  Widget build(BuildContext context) {
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
                  NoticeSnackBar.show(context, '공지 사항이 수정 되었습니다.');
                  Navigator.of(context).popUntil((route) => route.isFirst);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoticeListRoute()));
                }
              }),
        ],
      ),
      body: Form(
        key: formKey,
        child: Container(
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
                      hintText: '제목',
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
                  //initialValue: notice.contents,
                  controller: contentTextController,
                  decoration: InputDecoration(hintText: '내용을 입력하세요.'),
                  maxLines: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
