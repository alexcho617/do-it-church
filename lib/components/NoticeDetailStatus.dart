import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../constants.dart';

class NoticeDetailStatus extends StatelessWidget {
  const NoticeDetailStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
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
                Text('10', style: kNoticeCountTextStyle)
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(left: 180),
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
        ),
      ]),
    );
  }
}
