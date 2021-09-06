import 'package:flutter/material.dart';

import '../constants.dart';

class NoticeHomeStatus extends StatelessWidget {
  const NoticeHomeStatus({
    Key? key,
    required this.commentCounts,
  }) : super(key: key);
  final String commentCounts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
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
                Icon(Icons.favorite, size: 12, color: Colors.red),
                Container(
                  width: 5,
                ),
                Text('5', style: kNoticeCountTextStyle)
              ],
            ),
          ),
          Container(child: Row(
            children: [
              Icon(Icons.chat_outlined, size: 12, color: Colors.grey),
              Container(
                width: 5,
              ),
              Text(commentCounts, style: kNoticeCountTextStyle),
            ],
          )),
        ],
      ),
    );
  }
}
