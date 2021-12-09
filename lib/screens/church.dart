import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it_church/components/customUser.dart';
import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/landing_route.dart';
import 'package:do_it_church/screens/register.dart';
import 'package:do_it_church/services/myfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ChurchRoute extends StatefulWidget {
  ChurchRoute({required CustomUser newUser});
  @override
  _ChurchRouteState createState() => _ChurchRouteState();
  CustomUser myUser = CustomUser();
}

class _ChurchRouteState extends State<ChurchRoute> {
  var arguments = Get.arguments;
  final _auth = FirebaseAuth.instance;

  String churchId = '';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _churchName;
  late CustomUser myUser;
  @override
  void initState() {
    super.initState();
    print('church_init:widget.myuser.name:${widget.myUser.name}');
    _churchName = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('churchName') ?? 'churchName_empty';
    });

    myUser = arguments;
  }

  TextEditingController _churchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '교회선택',
          style: kAppBarTitleTextStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
              ),
              Text('교회이름'),
              TextField(controller: _churchController),
              SizedBox(
                height: 50,
              ),
              TextButton(
                child: Text(
                  '찾기',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
                ),
                onPressed: () {
                  performChurchNameCheck();
                  //check church from firebase
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void performChurchNameCheck() async {
    String targetChurchName = _churchController.text;
    if (targetChurchName != '') {
      if (await firestoreChurchName(targetChurchName) == true) {
        await firestoreSetChurchId(targetChurchName);
        // print('churchroute_$targetId');
        // add to preference for later use
        await _prefSaveChurch();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingRoute()));
      } else {
        //교회 추가 기능 나중에 개발하기
        print('Church Not Found');
      }
    } else {
      print('EMPTY STRING');
    }
  }

  Future<void> _prefSaveChurch() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _churchName =
          prefs.setString('churchName', churchId).then((bool success) {
        print('church.dart_prefSaveChurch: $_churchName');
        return _churchName;
      });
    });
  }

  firestoreSetChurchId(String churchName) async {
    final user = _auth.currentUser;
    User loggedInUser = user!;
    await firestore
        .collection('Church')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["name"] == churchName) {
          setState(() {
            churchId = doc.id;
          });
        }
      });
    });
    //this works but having trouble getting user object.
    await firestore
        .collection('Church')
        .doc(churchId)
        .collection('User')
        .doc(loggedInUser.uid)
        .set({
      'birthdate': myUser.birthdate,
      'gender': myUser.gender,
      'name': myUser.name,
      'phone_num': myUser.phoneNumber,
      'uid': loggedInUser.uid
    });
  }
}

//shared_preference 사용할것