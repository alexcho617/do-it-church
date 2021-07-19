import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: LoginRoute(),
  ));
}

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

//NOTICE SCREEN/////////////////////////////////////////////
class NoticeRoute extends StatefulWidget {
  const NoticeRoute({Key? key}) : super(key: key);

  @override
  _NoticeRouteState createState() => _NoticeRouteState();
}

class _NoticeRouteState extends State<NoticeRoute> {
  String notice1 = 'God is good, all the time.';
  String notice2 = 'All the time, God is good.';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: (Text('Do It Church - Notice')),
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade300,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: const TextField(
                //search bar
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Colors.deepPurpleAccent,
                ),
                title: Text(
                  'Notice 1',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    letterSpacing: 1,
                    color: Colors.deepPurple.shade300,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Colors.deepPurpleAccent,
                ),
                title: Text(
                  'Notice 2',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    letterSpacing: 1,
                    color: Colors.deepPurple.shade300,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          // add new notice
          onPressed: () {
            //pressed stuff here
            //go to third screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewNoticeRoute()),
            );
            //Navigator.pop(context);
          },
          child: const Icon(Icons.add_circle),
          backgroundColor: Colors.deepPurple.shade300,
        ),
      ),
    );
  }
}

//NEW NOTICE///////////////
class NewNoticeRoute extends StatefulWidget {
  const NewNoticeRoute({Key? key}) : super(key: key);

  @override
  _NewNoticeRouteState createState() => _NewNoticeRouteState();
}

class _NewNoticeRouteState extends State<NewNoticeRoute> {
  String noticeTitle = '';
  String noticeContents = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              print('New Notice Title = $noticeTitle');
              print('New Notice Contents = $noticeContents');
              Navigator.pop(context);
            },
          ),
          title: (Text('New Notice')),
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade300,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: TextField(
                onChanged: (value3) => noticeTitle = value3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: TextField(
                onChanged: (value4) => noticeContents = value4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contents',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
