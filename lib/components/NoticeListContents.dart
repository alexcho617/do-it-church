import 'package:flutter/material.dart';
import '../constants.dart';

class NoticeListContents extends StatelessWidget {
  const NoticeListContents({
    Key? key,
    required this.contents,
  }) : super(key: key);

  final contents;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        text: TextSpan(text: '$contents', style: kNoticeContentTextStyle),
      ),
    );
  }
}
