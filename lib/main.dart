import 'package:do_it_church/screens/home_route.dart';
import 'package:flutter/material.dart';
import 'screens/login_route.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF89A1F8),
        iconTheme: IconThemeData(color: Color(0xFF89A1F8)),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: const Color(0xff89A1F8)),
            primary: const Color(0xff89A1F8),
          ),
        ),
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
    ),
  );
}
