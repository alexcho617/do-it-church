import 'package:flutter/material.dart';
import 'screens/login_route.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color(0xFF89A1F8),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 16,
          letterSpacing: 1,
          color: Color(0xFF89A1F8),
        ),
      ),
    ),
    title: 'DoItChurch Navigation',
    home: LoginRoute(),
  ));
}
