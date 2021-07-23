import 'package:flutter/material.dart';

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

              // Alert(
              //         context: context,
              //         title: "Done!",
              //         desc: "New notice is added.")
              //     .show();
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
