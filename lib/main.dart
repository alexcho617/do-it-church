import 'package:do_it_church/screens/church.dart';
import 'package:do_it_church/screens/landing_route.dart';
import 'package:do_it_church/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_it_church/screens/home.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFF89A1F8),
        iconTheme: IconThemeData(color: Color(0xFF89A1F8)),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: const Color(0xff89A1F8)),
            primary: const Color(0xff89A1F8),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Color(0xFF687AB5),
          ),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Color(0xFF89A1F8)),
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
      home: InitializerWidget(),
    ),
  );
}

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      User loggedInUser = user;
      //1
      print(
          'AUTO LOG IN SUCCESS(main.dart): Signed in As:${loggedInUser.phoneNumber}');
      //2
      return LandingRoute(
        
      );
      // return HomeRoute();
    } else {
      return LoginRoute();
    }
  }
}
