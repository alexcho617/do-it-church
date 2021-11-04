import 'package:flutter/material.dart';

class ScreenDivider extends StatelessWidget {
  const ScreenDivider({
    Key? key,
    required this.color,
    required this.thickness,
  }) : super(key: key);
  final Color color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      child: Divider(
        height: 1,
        thickness: thickness,
        color: color,
      ),
    );
  }
}
