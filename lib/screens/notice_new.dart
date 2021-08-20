import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_it_church/components/notice.dart';

class NoticeAddRoute extends StatefulWidget {
  @override
  _NoticeAddRouteState createState() => _NoticeAddRouteState();
}

class _NoticeAddRouteState extends State<NoticeAddRoute> {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Notice notice = Notice();

  void assignCurrentWriter() async {
    final user = _auth.currentUser;
    if(user != null){
      User loggedInUser = user;
      print('SUCCESS(notice_new_screen): Signed in As:${loggedInUser.phoneNumber}');
      notice.writer = loggedInUser.phoneNumber;
    }
  }

  @override
  void initState() {
    super.initState();
    assignCurrentWriter();
  }

  @override
  //String noticeTitle = '';
  //String noticeContents = '';
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    // final size = mediaQuery.size.width;
    int screenIndex = 0;
    List<Widget> screenList = [
      Text('홈스크린'),
      Text('채팅'),
      Text('활동가이드화면'),
      Text('모아보기화면')
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '공지작성',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
            color: Colors.black54,
            icon: Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                //
              });
            }),
        leadingWidth: 20,
        actions: [
          TextButton(
              child: Text(
                '완료',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                //notice.writer =
                firestore.collection('Notice').add({
                  'title': notice.title,
                  'contents': notice.contents,
                  'writer' : notice.writer,
                  'date' : Timestamp.now(),
                });
                Navigator.pop(context);
              }),
        ],
      ),


      body: Center(
          child: Column(
            children: [
              Container(
                height: 450,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    TextField(
                      autocorrect: true,
                      onChanged: (value3) => notice.title = value3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '제목',
                        hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                    TextField(
                      onChanged: (value4) => notice.contents = value4,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '여기 내용을 입력하세요',
                      ),
                    ),
                  ],
                ),
              ),
                  Divider(
                    thickness:1.0,
                    indent: 15,
                    endIndent: 15,
                  ),

              Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(Icons.add_to_photos),
                        onPressed: (){

                        }
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
