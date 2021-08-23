import 'package:flutter/material.dart';

class ScreenDivider extends StatelessWidget {
  const ScreenDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 20,
      child: Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}
