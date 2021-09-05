import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../constants.dart';
class NoticeDetailStatus extends StatefulWidget {
  NoticeDetailStatus({Key? key,}) : super(key: key);

  @override
  _NoticeDetailStatusState createState() => _NoticeDetailStatusState();
}

class _NoticeDetailStatusState extends State<NoticeDetailStatus> {

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
                  size: 17,
                  color: Colors.grey,
                ),
                Container(
                  width: 5,
                ),
                Text('23', style: kNoticeCountTextStyle),
                Container(
                  width: 10,
                ),
                Icon(Icons.chat_outlined, size: 17, color: Colors.grey),
                Container(
                  width: 5,
                ),
                Text('5', style: kNoticeCountTextStyle,overflow: TextOverflow.ellipsis,),
                //Text('${['comment'].length}', style: kNoticeCountTextStyle,overflow: TextOverflow.ellipsis,),
                //지워도 되는거... 댓글 수 가져오는거 시도해본거..


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
