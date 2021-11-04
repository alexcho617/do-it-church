import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/screens/notice_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../constants.dart';

  final firestore = FirebaseFirestore.instance;


class NoticeDetailStatus extends StatefulWidget {
  NoticeDetailStatus({required this.commentCounts});

  final String commentCounts;

  @override
  _NoticeDetailStatusState createState() => _NoticeDetailStatusState();
}


class _NoticeDetailStatusState extends State<NoticeDetailStatus> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
          children: <Widget>[
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
            isLiked: false,
            likeCount: 2,
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
              //likeCount += isLiked ? 1 : -1;
              return isLiked;
            },
          ),
        ),
      ]),
    );
  }
}
