import 'package:do_it_church/screens/landing_route.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      print('SUCCESS(main.dart): Signed in As:${loggedInUser.phoneNumber}');
      //landingPage로 가게 할
      return LandingRoute();
    } else {
      return LoginRoute();
    }
  }
}
