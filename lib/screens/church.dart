import 'package:flutter/material.dart';

class ChurchPage extends StatefulWidget {
  const ChurchPage({Key? key}) : super(key: key);

  @override
  _ChurchPageState createState() => _ChurchPageState();
}

class _ChurchPageState extends State<ChurchPage> {
  TextEditingController _churchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Church Selection'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Text('Church'),
            TextField(controller: _churchController),
            TextButton(
              child: Text('findChurch'),
              onPressed: () {
                //check church from firebase
              },
            )
          ],
        ),
      ),
    );
  }
}
