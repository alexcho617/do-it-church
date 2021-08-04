import 'package:flutter/material.dart';
import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/register.dart';
import 'package:do_it_church/screens/find_id.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({required this.textInput, required this.buttonInput, Key? key})
      : super(key: key);

  final String textInput;
  final String buttonInput;

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: TextField(
            controller: phoneController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: widget.textInput,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
            ),
            child: Text(
              widget.buttonInput,
              style: kLogInButtonTextStyle,
            ),
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
                    MaterialPageRoute(builder: (context) => RegisterRoute()),
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
    );
  }
}
