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
    required this.date,
  }) : super(key: key);

  final docId;
  final title;
  final writer;
  final date;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 43,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    minLeadingWidth: 10,
                    leading: Icon(
                      Icons.notes_rounded,
                      color: Colors.black,
                    ),
                    trailing: NoticeEditButton(docId: docId, title: title),
                    title: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoticeDetail(
                                      noticeId: '$docId',
                                    )));
                      },
                      style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.zero),
                      child: Text(
                        '$title',
                        style: kNoticeTitleTextStyle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    children: [
                      Text(
                        '$date',
                        style: kNoticeSubTitleTextStyle,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '$writer',
                        style: kNoticeSubTitleTextStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
