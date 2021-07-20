import 'package:flutter/material.dart';
import 'notice_route.dart';

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
            //crossAxisAlignment: CrossAxisAlignment.center,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: TextField(
                  onChanged: (value1) => userName = value1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: TextField(
                  onChanged: (value2) => passWord = value2,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              //login button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple.shade300),
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
                      child: Text('Log In'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple.shade300),
                      ),
                      onPressed: () {
                        setState(() {
                          print('Register Pressed');
                        });
                      },
                      child: Text('Register'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple.shade300),
                      ),
                      onPressed: () {
                        setState(() {
                          print('Test Pressed');
                        });
                      },
                      child: Text('Test'),
                    ),
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
