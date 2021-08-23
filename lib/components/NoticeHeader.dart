import 'package:do_it_church/screens/notice_detail.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'EditButton.dart';

class NoticeHeader extends StatelessWidget {
  const NoticeHeader({
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
              title: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoticeDetail(
                                noticeId: '$docId',
                              )));
                },
                style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                child: Text(
                  '$title',
                  style: kNoticeTitleTextStyle,
                ),
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
