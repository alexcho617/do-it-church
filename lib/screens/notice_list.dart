import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/notice.dart';
import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/notice_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'notice_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:like_button/like_button.dart';

final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
Notice notice = Notice();

class NoticeListRoute extends StatefulWidget {
  @override
  _NoticeListRouteState createState() => _NoticeListRouteState();
}

class _NoticeListRouteState extends State<NoticeListRoute> {


  //User loggedInUser; //getting error
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        loggedInUser = notice.writer;
        print(
            'SUCCESS(notice_list_screen): Signed in As:${loggedInUser.phoneNumber}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '공지사항',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            }),
        leadingWidth: 20,
        actions: [
          IconButton(
              icon: Icon(
                Icons.create_rounded,
                color: Color(0xFF89A1F8),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoticeAddRoute()),
                );
                setState(() {});
              }),
        ],
      ),
      body:  Center(
        child: Column(
          children: <Widget>[
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => NoticeDetail()),
            //     );
            //     setState(() {});
            //     },
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffE5E5E5),
                    width: 4.0,
                  ),
                ),
              ),
                child:
                    NoticeStream(),
            ),

          ],
        ),
      ),
    );
  }
}

class NoticeStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('Notice').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final docs = (snapshot.data!).docs;
        //(snapshot.data!).docs.map((DocumentSnapshot document)
        List<NoticeListView> noticelists = [];

        for (var doc in docs) {
          notice.title = doc.get("title").toString();
          notice.date = doc.get("date");
          notice.contents = doc.get("contents").toString();
          print(notice.title);
          print(notice.date);
          print(notice.contents);
          final noticelist = NoticeListView(
              title: notice.title,
              date: notice.date,
              contents: notice.contents,
          );
          noticelists.add(noticelist);
        }
        return Expanded(
            child: ListView(
              children: noticelists,
            ),
          );
      },
    );
  }
}

class NoticeListView extends StatelessWidget {
  const NoticeListView({this.title, this.date, this.contents});
  final title;
  final date;
  final contents;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notes_rounded,
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '$title',
                        style: kNoticeTitleTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        //날짜 + 작성자 서버에서 받아서 변수로 출력
                        '$date',
                        style: kNoticeSubTitleTextStyle,
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            text: TextSpan(
                                text:
                                '$contents',
                                style: kNoticeContentTextStyle),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('글 수정하기'),
                        ),
                        ListTile(
                          title: Text('공유하기'),
                        ),
                        ListTile(
                          title: Text('삭제하기'),
                        ),
                      ],
                    );
                  });
            },
          ),
          Row(
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                size: 12,
                color: Colors.grey,
              ),
              Container(
                width: 5,
              ),
              Text('25', style: kNoticeCountTextStyle),
              Container(
                width: 10,
              ),
              Icon(Icons.chat_outlined, size: 12, color: Colors.grey),
              Container(
                width: 5,
              ),
              Text('10', style: kNoticeCountTextStyle)
            ],
          ),
          Container(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                //ElevatedButton, OutlinedButton
                child: SizedBox(
                  height: 27,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero
                    ),
                    onPressed: () async {},
                    child: LikeButton(
                      isLiked: false,
                      likeCount: 17,
                      likeBuilder: (isLiked){
                        final color = isLiked ? Colors.red : Colors.grey;
                        return Icon(Icons.favorite, color: color, size: 13);
                      },
                      likeCountPadding: EdgeInsets.zero,
                      countBuilder: (count, isLiked, text) {
                        final color = isLiked ? Color(0xFF89A1F8) : Colors.grey;
                        return Text(
                          text,
                          style: TextStyle(fontSize: 13, color: color),
                        );
                      },
                      onTap: (isLiked) async{
                        isLiked = !isLiked;
                        //likeCount += isLiked ? 1 : -1;
                        return !isLiked;
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: 27,
                  child: OutlinedButton(
                    onPressed: () { },
                    child:
                    Text('댓글쓰기', style: TextStyle(fontSize: 13)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}