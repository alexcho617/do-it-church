import 'package:do_it_church/screens/landing_route.dart';
import 'package:flutter/material.dart';
import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/register.dart';
import 'package:do_it_church/screens/find_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OPT_FORM_STATE,
}

//LOG IN SCREEN///////////////////////////////
class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  //final currentState = MobileVerificationState.SHOW_OPT_FORM_STATE;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = '';
  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingRoute()));
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getMobileFormWidget(context) {
    final phoneController = TextEditingController();
    final textInput = '핸드폰번호';
    final buttonInput = '인증코드 받기';

    return (Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: TextField(
            controller: phoneController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: textInput,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: ElevatedButton(
            //invoke firebase auth
            onPressed: () async {
              setState(() {
                showLoading = true;
              });

              await _auth.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
                  verificationCompleted: (phoneAuthCredential) async {
                    setState(() {
                      showLoading = false;
                    });
                    //signInWithPhoneAuthCredential(phoneAuthCredential); not needed yet
                  },
                  verificationFailed: (verificationFailed) async {
                    setState(() {
                      showLoading = false;
                    });
                    // _scaffoldKey.currentState.showSnackBar(
                    //     SnackBar(content: Text(verificationFailed.message)));
                    print(verificationFailed.message);
                  },
                  codeSent: (verificationId, resendingToken) async {
                    setState(() {
                      showLoading = false;
                      currentState =
                          MobileVerificationState.SHOW_OPT_FORM_STATE;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) async {});
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
            ),
            child: Text(
              buttonInput,
              style: kLogInButtonTextStyle,
            ),
          ),
        ),
        //login button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                style: TextButton.styleFrom(primary: Colors.black54),
                child: Text('회원가입'),
                onPressed: () {
                  setState(() {
                    print('register button pressed');
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterRoute()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                style: TextButton.styleFrom(primary: Colors.black54),
                child: Text('이메일/비밀번호 찾기'),
                onPressed: () {
                  setState(() {
                    print('find id/pw  button pressed');
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindId()),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ));
  }

  getOtpFormWidget(context) {
    final otpController = TextEditingController();
    final textInput = '인증코드';
    final buttonInput = '인증하기';

    return (Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: TextField(
            controller: otpController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: textInput,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: ElevatedButton(
            //invoke firebase auth
            onPressed: () async {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otpController.text);
              signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
            ),
            child: Text(
              buttonInput,
              style: kLogInButtonTextStyle,
            ),
          ),
        ),
        //login button
      ],
    ));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      'images/logo.png'), //always add images in directory
                  radius: 75,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: showLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : currentState ==
                            MobileVerificationState.SHOW_MOBILE_FORM_STATE
                        ? getMobileFormWidget(context)
                        : getOtpFormWidget(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
