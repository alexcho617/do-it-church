import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/screens/notice_detail.dart';
import 'package:do_it_church/services/myfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../constants.dart';

final firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class NoticeDetailStatus extends StatefulWidget {
  NoticeDetailStatus({
    required this.commentCounts,
    required this.docId,
    required this.likeCounts,
    required this.isLiked,
  });

  final String commentCounts;
  final String docId;
  String likeCounts;
  bool isLiked;
  @override
  _NoticeDetailStatusState createState() => _NoticeDetailStatusState();
}

class _NoticeDetailStatusState extends State<NoticeDetailStatus> {
  late String uid;
  late String likes;
  void getCurretnUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      User loggedInUser = user;
      print(
          'SUCCESS(notice_new_screen): Signed in As:${loggedInUser.phoneNumber}');
      uid = loggedInUser.uid;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurretnUser();
    // getLikeCount();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                size: 19,
                color: Colors.grey,
              ),
              Container(
                width: 5,
              ),
              Text('25', style: kNoticeCountTextStyle),
              Container(
                width: 10,
              ),
              Icon(Icons.chat_outlined, size: 19, color: Colors.grey),
              Container(
                width: 5,
              ),
              Text(widget.commentCounts, style: kNoticeCountTextStyle)
            ],
          ),
        ),
        Container(
          child: LikeButton(
            isLiked: isLiked,
            likeCount: int.parse(widget.likeCounts),
            likeBuilder: (isLiked) {
              final color = isLiked ? Colors.red : Colors.grey;
              return Icon(Icons.favorite, color: color, size: 19);
            },
            likeCountPadding: EdgeInsets.zero,
            countBuilder: (count, isLiked, text) {
              final color = isLiked ? Color(0xFF89A1F8) : Colors.grey;
              return Text(
                text,
                style: TextStyle(fontSize: 13, color: color),
              );
            },
            onTap: (isLiked) async {
              isLiked = !isLiked;
              addLikedList(uid, widget.docId);
              return isLiked;
            },
          ),
        ),
      ]),
    );
  }
}
