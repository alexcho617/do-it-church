import 'package:do_it_church/screens/landing_route.dart';
import 'package:flutter/material.dart';
import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/register.dart';
import 'package:do_it_church/screens/find_id.dart';

import 'package:firebase_auth/firebase_auth.dart';

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
        //add to firestore
        final user = _auth.currentUser;
        User loggedInUser = user!;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingRoute()));
      }
    } on Exception catch (e) {
      setState(() {
        showLoading = false;
        //TODO 2:Add some kind of snackbar
        //goes back to phone number entering stage
        print('err from signInWithPhoneAUthCredential function call back');
        currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
      });
      print(e);
    }
  }

  getMobileFormWidget(context) {
    final phoneController = TextEditingController();
    final textInput = '휴대폰번호';
    final buttonInput = '로그인';

    return (Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: TextField(
            keyboardType: TextInputType.phone,
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
              //this cannot happen because of authorization rule.

              setState(() {
                showLoading = true;
              });
              //use if to differentiate 010,011. is it really neccessary?
              String processedPhoneNumber = '+8210' + phoneController.text;
              //get all phoneNumbers
              //TODO 1:check if number is in database
              //login
              await _auth.verifyPhoneNumber(
                phoneNumber: processedPhoneNumber,
                verificationCompleted: (phoneAuthCredential) async {
                  setState(() {
                    print('verificationCompleted');
                    showLoading = false;
                  });
                  signInWithPhoneAuthCredential(
                      phoneAuthCredential); //not needed yet
                },
                verificationFailed: (verificationFailed) async {
                  setState(() {
                    print('verificationFailed');
                    showLoading = false;
                  });

                  print(verificationFailed.message);
                  setState(() {
                    showLoading = false;
                    currentState =
                        MobileVerificationState.SHOW_MOBILE_FORM_STATE;
                  });
                  print('error from verificationFailed');
                },
                codeSent: (verificationId, resendingToken) async {
                  print('codeSent');
                  setState(() {
                    showLoading = false;
                    currentState = MobileVerificationState.SHOW_OPT_FORM_STATE;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            style: TextButton.styleFrom(primary: Colors.black54),
            child: Text('회원가입'),
            onPressed: () {
              setState(() {
                print('register button pressed');
              });

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RegisterRoute()),
              );
            },
          ),
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
            keyboardType: TextInputType.phone,
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
