import 'package:flutter/material.dart';
import 'notice_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_it_church/components/loginWidget.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

//LOG IN SCREEN///////////////////////////////
class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  //final currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;


  getMobileFormWidget(context){
    return LoginWidget(
      textInput: '핸드폰번호',
      buttonInput: '인증코드 받기',
    );
  }

  getOtpFormWidget(context){
    return LoginWidget(
      textInput: '인증코드',
      buttonInput: '인증',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                child: currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
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