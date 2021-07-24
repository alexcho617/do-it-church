import 'package:flutter/material.dart';

const kTextButtonTextStyle =
    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

const kLogInButtonTextStyle =
    TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

const kElevatedButtonTextStyle =
    TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

const kStartButtonTextStyle =
    TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold);

// constant로 정의가 안되긴 하지만 일단 여기에 써 놓음, ElevatedButton 모양, 색 처리 할 때 사용.
var kRoundBorderButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  side: MaterialStateProperty.all(BorderSide(color: Color(0xFF89A1F8))),
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
);
