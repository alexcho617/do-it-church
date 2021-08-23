import 'package:flutter/material.dart';

class NoticeEditButton extends StatelessWidget {
  const NoticeEditButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
    );
  }
}
