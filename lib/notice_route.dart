import 'package:flutter/material.dart';
import 'new_notice_route.dart';

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
