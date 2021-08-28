import 'package:flutter/material.dart';

class ScreenDivider extends StatelessWidget {
  const ScreenDivider({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      child: Divider(
        height: 1,
        thickness: 2,
        color: color,
      ),
    );
  }
}
