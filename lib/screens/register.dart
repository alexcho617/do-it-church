import 'package:do_it_church/screens/church.dart';
import 'package:do_it_church/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/customUser.dart';
import 'package:do_it_church/constants.dart';
import 'landing_route.dart';
import 'package:intl/intl.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

enum Gender { male, female }

class RegisterRoute extends StatefulWidget {
  RegisterRoute({this.churchId});

  @override
  _RegisterRouteState createState() => _RegisterRouteState();
  var churchId;
}

class _RegisterRouteState extends State<RegisterRoute> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormFieldState>();

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String verificationId = '';
  bool showLoading = false;
  bool showStartLoading = false;

  CustomUser myUser = CustomUser();

  String name = '';
  DateTime dateTime = DateTime.now();
  Gender? selectedGender; // since null, gender card starts with inActiveColor.

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showStartLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showStartLoading = false;
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
//this part should be delegated to church.dart
        // await _firestore
        //     .collection('Church')
        //     .doc(HomeRoute.currentChurchId)
        //     // .doc('gG1rW7bUraMtRdJTUnFr')
        //     .collection('User')
        //     .doc(loggedInUser.uid)
        //     .set({
        //   'birthdate': myUser.birthdate,
        //   'gender': myUser.gender,
        //   'name': myUser.name,
        //   'phone_num': myUser.phoneNumber,
        //   'uid': loggedInUser.uid
        // });
        print('register user info');
        print(myUser.name);
        print(myUser.birthdate);
        print(myUser.phoneNumber);
        print('----------------');

        Get.off(ChurchRoute(newUser: myUser),arguments: myUser);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ChurchRoute(
        //               newUser: myUser,
        //             )));
      }
    } on Exception catch (e) {
      print(e);
      setState(() {
        showStartLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var spinKit = SpinKitThreeBounce(
        size: 15.0,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(decoration: BoxDecoration(color: Colors.white));
        });

    var spinStartButton = SpinKitThreeBounce(
        size: 15.0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: screenWidth * 0.75,
            child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFF89A1F8))),
          );
        });

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
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Hero(
              tag: 'logo',
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    'images/logo.png'), //always add images in directory
                radius: 25,
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '????????? ???????????????';
                          }
                          return null;
                        },
                        onChanged: (value) => myUser.name = value,
                        decoration: const InputDecoration(labelText: "??????"),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '???????????? : ${myUser.birthdate ?? '01/01/1991'}',
                            style: kRegularTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            }
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                  actions: [
                                    SizedBox(
                                      height: 180,
                                      child: CupertinoDatePicker(
                                        minimumYear: 1950,
                                        maximumYear: DateTime.now().year,
                                        initialDateTime: dateTime,
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (dateTime) =>
                                            setState(
                                                () => this.dateTime = dateTime),
                                      ),
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    child: Text('Done'),
                                    onPressed: () {
                                      final value = DateFormat('MM/dd/yyyy')
                                          .format(dateTime);
                                      setState(() {
                                        myUser.birthdate = value;
                                      });
                                      print(
                                          'User Birthdate:${myUser.birthdate}');
                                      Navigator.pop(context);
                                    },
                                  )),
                            );
                          },
                          child: Icon(Icons.date_range),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF89A1F8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: selectedGender == Gender.male
                                  ? MaterialStateProperty.all<Color>(
                                      Colors.white)
                                  : MaterialStateProperty.all<Color>(
                                      Color(0xFF89A1F8)),
                              side: selectedGender == Gender.male
                                  ? MaterialStateProperty.all(BorderSide(
                                      color: Color(0xFF89A1F8),
                                      width: 2.0,
                                    ))
                                  : MaterialStateProperty.all(BorderSide(
                                      color: Color(0xFF89A1F8),
                                      width: 2.0,
                                    )),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                            ),
                            onPressed: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              }
                              setState(() {
                                selectedGender = Gender.male;
                                myUser.gender = 'male';
                                print('User Gender: ${myUser.gender}');
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('??????',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: selectedGender == Gender.male
                                          ? Color(0xFF89A1F8)
                                          : Colors.white,
                                    )),
                                Icon(
                                  Icons.male,
                                  color: selectedGender == Gender.male
                                      ? Color(0xFF89A1F8)
                                      : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: selectedGender == Gender.female
                                  ? MaterialStateProperty.all<Color>(
                                      Colors.white)
                                  : MaterialStateProperty.all<Color>(
                                      Color(0xFF89A1F8)),
                              side: selectedGender == Gender.female
                                  ? MaterialStateProperty.all(BorderSide(
                                      color: Color(0xFF89A1F8),
                                      width: 2.0,
                                    ))
                                  : MaterialStateProperty.all(BorderSide(
                                      color: Color(0xFF89A1F8),
                                      width: 2.0,
                                    )),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                            ),
                            onPressed: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              }
                              setState(() {
                                selectedGender = Gender.female;
                                myUser.gender = 'female';
                                print('User Gender: ${myUser.gender}');
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '??????',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: selectedGender == Gender.female
                                        ? Color(0xFF89A1F8)
                                        : Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.female,
                                  color: selectedGender == Gender.female
                                      ? Color(0xFF89A1F8)
                                      : Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            key: phoneNumberKey,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '????????? ????????? ???????????????';
                              }
                              if (value.length < 8) {
                                return '010??? ??? 8????????? ???????????????';
                              }
                              return null;
                            },
                            controller: phoneController,
                            onChanged: (value) => myUser.phoneNumber = value,
                            decoration:
                                const InputDecoration(labelText: "????????????"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: ElevatedButton(
                          child: showLoading
                              ? Center(child: spinKit)
                              : Text(
                                  '???????????? ??????',
                                  style: kElevatedButtonTextStyle,
                                ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF89A1F8)),
                          ),
                          onPressed: () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            }
                            if (this.phoneNumberKey.currentState!.validate()) {
                              setState(() {
                                showLoading = true;
                              });
                              String processedPhoneNumber =
                                  '+82' + phoneController.text.substring(1, 11);
                              await _auth.verifyPhoneNumber(
                                phoneNumber: processedPhoneNumber,
                                verificationCompleted:
                                    (phoneAuthCredential) async {
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
                                  });
                                  print('error from verificationFailed');
                                },
                                codeSent:
                                    (verificationId, resendingToken) async {
                                  print('codeSent');
                                  setState(() {
                                    showLoading = false;
                                    this.verificationId = verificationId;
                                  });
                                },
                                codeAutoRetrievalTimeout:
                                    (verificationId) async {},
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  //authentication code
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '??????????????? ???????????????';
                          }
                          return null;
                        },
                        controller: otpController,
                        decoration: const InputDecoration(labelText: "????????????"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: screenWidth * 0.75,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          side: MaterialStateProperty.all(BorderSide(
                            color: Color(0xFF89A1F8),
                            width: 2.0,
                          )),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        child: showStartLoading
                            ? Center(child: spinStartButton)
                            : Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '???????????? ????????????',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xFF89A1F8),
                                  ),
                                ),
                              ),
                        onPressed: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus &&
                              currentFocus.focusedChild != null) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          }
                          if (this.formKey.currentState!.validate()) {
                            try {
                              //make credential
                              PhoneAuthCredential phoneAuthCredential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: otpController.text);
                              //function call
                              signInWithPhoneAuthCredential(
                                  phoneAuthCredential);
                            } catch (e) {
                              print(e);
                            }
                            print(myUser.name);
                            print(myUser.birthdate);
                            print(myUser.gender);
                            print(myUser.phoneNumber);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
