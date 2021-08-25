import 'package:do_it_church/screens/landing_route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_it_church/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
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
      print(
          'AUTO LOG IN SUCCESS(main.dart): Signed in As:${loggedInUser.phoneNumber}');
      /*
      * for auto log in, state management 사용 해야함,, logic  and state is separated
      * bloc - large scale, heavy ,
      * provider-hamsung currently using provider - > official doc by flutter
      * getx- easier to use, state manage and navigator **recommeneded
      *   official doc,
      *   youtube codingfactory korean
      *
      * */
      //landingPage로 가게 할
      return LandingRoute();
    } else {
      return HomeRoute();
    }
  }
}
