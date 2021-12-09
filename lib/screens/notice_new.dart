import 'package:do_it_church/components/NoticeSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'home.dart';

void _handleSubmitted(String titleText, String contentText) async {
  final firebaseStorageRef = FirebaseStorage.instance
      .ref()
      .child(HomeRoute.currentChurchId)
      .child('notice')
      .child('${titleText.toString()}.png');
  final uploadTask = firebaseStorageRef.putFile(File(imageURI!.path));
  await uploadTask.whenComplete(() => null);
  final downloadUrl = await firebaseStorageRef.getDownloadURL();
  await firestore
      .collection('Church')
      .doc(HomeRoute.currentChurchId)
      .collection('Notice')
      .add({
    'title': titleText,
    'contents': contentText,
    'writer': notice.writer,
    //server
    'date': Timestamp.now(),
    'commentCount': notice.commentCount ?? 0,
    'likeCount': notice.likeCount ?? 0,
    'likedUsers': initialList,
    'imageUrl': downloadUrl,
  });
}

Notice notice = Notice();
final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
List<dynamic> initialList = [];
XFile? imageURI;
final ImagePicker _picker = ImagePicker();

class NoticeAddRoute extends StatefulWidget {
  @override
  _NoticeAddRouteState createState() => _NoticeAddRouteState();
}

class _NoticeAddRouteState extends State<NoticeAddRoute> {
  final contentTextController = TextEditingController();
  final titleTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future getImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
    });
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
          .collection('Church')
          .doc(HomeRoute.currentChurchId)
          .collection('User')
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
                  NoticeSnackBar.show(context, '공지 사항이 추가 되었습니다.');
                  Navigator.pop(context);
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
                  maxLines: 20,
                ),
              ),
              IconButton(
                icon: Icon(Icons.file_upload),
                onPressed: () {
                  getImage();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
