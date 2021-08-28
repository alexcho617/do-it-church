import 'package:flutter/material.dart';

class ScreenDivider extends StatelessWidget {
  const ScreenDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      child: Divider(
        thickness: 2,
        color: Color(0xFFE0E0E0),
      ),
    );
  }
}
