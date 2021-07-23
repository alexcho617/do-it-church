import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/register_route.dart';
import 'package:do_it_church/screens/notice_route.dart';
import 'package:flutter/material.dart';

//LOG IN SCREEN///////////////////////////////
class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  String userName = '';
  String passWord = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                    'images/logo.png'), //always add images in directory
                radius: 75,
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
                      onChanged: (value1) => userName = value1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '아이디',
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
                      child: Text(
                        '로그인',
                        style: kLogInButtonTextStyle,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
                      ),
                      onPressed: () {
                        setState(() {
                          //To change state here
                        });
                        print('User Name = $userName');
                        print('Password = $passWord');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoticeRoute()),
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
                          child: Text('아이디/비밀번호 찾기'),
                          onPressed: () {
                            setState(() {
                              print('find id/pw  button pressed');
                            });
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterRoute()),);
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
