import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/home.dart';
import 'package:do_it_church/screens/register.dart';
import 'package:do_it_church/screens/find_id.dart';
import 'package:flutter/material.dart';
import 'notice_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

//LOG IN SCREEN///////////////////////////////
class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final _auth = FirebaseAuth.instance;
  String userEmail = '';
  String passWord = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Clip Oval로 이미지 적용시켜볼것
              // ClipOval(
              //   child: Image.asset('images/logo.png'),
              // ),
              //circle avatar도 좋으나 ListTile 과 주로 함께 프로필사진 쓰는용도임
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4),
                    child: TextField(
                      onChanged: (value1) => userEmail = value1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '이메일',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4),
                    child: TextField(
                      onChanged: (value2) => passWord = value2,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '비밀번호',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
                      ),
                      child: Text(
                        '로그인',
                        style: kLogInButtonTextStyle,
                      ),
                      onPressed: () async {
                        try {
                          final newUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: userEmail, password: passWord);

                          if (newUser != null) {
                            print('login success');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoticeListRoute()),
                            );
                          }
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          //To change state here
                        });
                        print('User Email = $userEmail');
                        print('Password = $passWord');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeRoute()),
                        );

                      },
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
                              MaterialPageRoute(
                                  builder: (context) => RegisterRoute()),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
