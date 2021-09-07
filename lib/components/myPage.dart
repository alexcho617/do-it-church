import 'package:do_it_church/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class myPageSlide extends StatelessWidget {
  myPageSlide({
    Key? key,
  }) : super(key: key);

  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print(
            'SUCCESS(mypage_screen): Signed in As:${loggedInUser.phoneNumber}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          DrawerHeader(child: Text('Drawer Header')),
          Container(
            child: Column(
              children: [
                ListTile(
                  title: const Text('MY'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('교회학교'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: (){},
                  child: Text('설정'),
                ),
                TextButton(
                    onPressed: () async {
                      await _auth.signOut();
                      print('SUCCESS(mypage_screen): Signed out');
                      Navigator.popUntil(
                          context, (Route<dynamic> route) => route.isFirst);

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginRoute()));
                    },
                    child: Text('로그아웃')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






//Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => MypageRoute()),
//                         );
//                         setState(() {});