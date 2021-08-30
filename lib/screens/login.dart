import 'package:do_it_church/screens/landing_route.dart';
import 'package:flutter/material.dart';
import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/register.dart';

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
    final phoneKey = GlobalKey<FormState>();

    final textInput = '휴대폰번호';
    final buttonInput = '로그인';

    return Form(
      key: phoneKey,
      child: (Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '핸드폰번호를 입력하세요';
                }
                if (value.length != 11 ||
                    value.contains('010') == false ||
                    value.contains(RegExp(r'[A-Z]')) == true ||
                    value.contains(RegExp(r'[a-z]')) == true) {
                  return '올바른 핸드폰번호 11자리를 입력하세요';
                }
                if (value.contains('-')) {
                  return '- 빼고 입력하세요';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 11,
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
                if (phoneKey.currentState!.validate()) {
                  setState(() {
                    showLoading = true;
                  });
                  //use if to differentiate 010,011. is it really neccessary?
                  String processedPhoneNumber =
                      '+82' + phoneController.text.substring(1, 11);
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
                        currentState =
                            MobileVerificationState.SHOW_OPT_FORM_STATE;
                        this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {},
                  );
                }
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
          Column(
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
            ],
          ),
        ],
      )),
    );
  }

  getOtpFormWidget(context) {
    final otpController = TextEditingController();
    final otpKey = GlobalKey<FormState>();
    final textInput = '인증코드';
    final buttonInput = '인증하기';

    return Form(
      key: otpKey,
      child: (Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '인증코드를 입력하세요';
                }
                return null;
              },
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
      )),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
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
      ),
    );
  }
}
