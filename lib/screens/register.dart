import 'package:flutter/material.dart';

import '../components/customUser.dart';
import 'package:do_it_church/constants.dart';
import 'landing_route.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO 3: handle null value
class RegisterRoute extends StatefulWidget {
  @override
  _RegisterRouteState createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String verificationId = '';

  CustomUser myUser = CustomUser();
  String name = '';

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      //showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        //showLoading = false;
      });
      if (authCredential.user != null) {
        //add to firestore
        final user = _auth.currentUser;
        User loggedInUser = user!;
        await _firestore
            .collection('userPhoneNumber')
            .doc(loggedInUser.uid)
            .set({
          'phoneNumber': loggedInUser.phoneNumber,
        });

        await _firestore.collection('Users').doc(loggedInUser.uid).set({
          'birthdate': myUser.birthdate,
          'gender': myUser.gender,
          'name': myUser.name,
          'phone_num': myUser.phoneNumber,
          'uid': loggedInUser.uid
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingRoute()));
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'logo',
          child: CircleAvatar(
            backgroundImage:
                AssetImage('images/logo.png'), //always add images in directory
            radius: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => myUser.name = value,
                decoration: const InputDecoration(labelText: "이름"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '생년월일 : ${myUser.birthdate ?? '1999.01.01'}',
                    style: kRegularTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.date_range),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: phoneController,
                    onChanged: (value) => myUser.phoneNumber = value,
                    decoration: const InputDecoration(labelText: "전화번호"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  child: Text(
                    '인증번호 전송',
                    style: kElevatedButtonTextStyle,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
                  ),
                  onPressed: () async {
                    String processedPhoneNumber =
                        '+8210' + phoneController.text;
                    await _auth.verifyPhoneNumber(
                      phoneNumber: processedPhoneNumber,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          print('verificationCompleted');
                          //showLoading = false;
                        });
                        signInWithPhoneAuthCredential(
                            phoneAuthCredential); //not needed yet
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          print('verificationFailed');
                          //showLoading = false;
                        });

                        print(verificationFailed.message);
                        setState(() {
                          //showLoading = false;
                          // currentState =
                          //     MobileVerificationState.SHOW_MOBILE_FORM_STATE;
                        });
                        print('error from verificationFailed');
                      },
                      codeSent: (verificationId, resendingToken) async {
                        print('codeSent');
                        setState(() {
                          //showLoading = false;
                          // currentState =
                          //     MobileVerificationState.SHOW_OPT_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    );
                  },
                ),
              ),
            ],
          ),
          //authentication code
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: otpController,
                decoration: const InputDecoration(labelText: "인증번호"),
              ),
            ),
          ),
          SizedBox(
            height: 175.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                side: MaterialStateProperty.all(BorderSide(
                  color: Color(0xFF89A1F8),
                  width: 2.0,
                )),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '두잇처치 시작하기',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF89A1F8),
                  ),
                ),
              ),
              onPressed: () async {
                try {
                  //make credential
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpController.text);
                  //function call
                  signInWithPhoneAuthCredential(phoneAuthCredential);
                } catch (e) {
                  print(e);
                }
                print(myUser.name);
                print(myUser.birthdate);
                print(myUser.gender);
                print(myUser.phoneNumber);
                setState(() {
                  //To change state here
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
