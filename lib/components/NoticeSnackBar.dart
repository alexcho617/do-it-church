import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeSnackBar {
  final String message;

  const NoticeSnackBar({
    required this.message,
  });

  static show(
      BuildContext context,
      String message,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          textColor: Color(0xFFFAF2FB),
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}