import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerPage extends StatefulWidget {
  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        minimumYear: 1950,
        maximumYear: DateTime.now().year,
        initialDateTime: dateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) =>
            setState(() => this.dateTime = dateTime),
      ),
    );
  }
}
