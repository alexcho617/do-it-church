import 'package:do_it_church/screens/notice_detail.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'EditButton.dart';

class NoticeDetailHeader extends StatelessWidget {
  const NoticeDetailHeader({
    Key? key,
    required this.docId,
    required this.title,
    required this.writer,
  }) : super(key: key);

  final docId;
  final title;
  final writer;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            child: ListTile(
              leading: Icon(
                Icons.notes_rounded,
                color: Colors.black,
              ),
              trailing: NoticeEditButton(),
              title: Text(
                '$title',
                style: kNoticeTitleTextStyle,
              ),
              subtitle: Text(
                '$writer',
                style: kNoticeSubTitleTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
