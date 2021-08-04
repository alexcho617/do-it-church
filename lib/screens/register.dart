import 'package:flutter/material.dart';
import '../components/user.dart';
import 'package:do_it_church/constants.dart';
import 'notice_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO: 코드 정리하고 NULL VALUE 핸들하기 (NULL AWARE OPERATOR 사용?)
class RegisterRoute extends StatefulWidget {
  @override
  _RegisterRouteState createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CustomUser myUser = CustomUser();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //title: Text('회원가입'),
        title: Hero(
          tag: 'logo',
          child: CircleAvatar(
            backgroundImage:
                AssetImage('images/logo.png'), //always add images in directory
            radius: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (textEmail) => myUser.email = textEmail,
                    decoration: const InputDecoration(labelText: "이메일"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  child: Text(
                    '중복확인',
                    style: kElevatedButtonTextStyle,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
                  ),
                  onPressed: () {
                    String checkID = myUser.email;
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('삐빅!! $checkID'),
                          content: Text('안돼 돌아가'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('돌아가자ㅜ'),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      //To change state here
                    });
                  },
                ),
              ),
            ],
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                obscureText: true,
                onChanged: (textPW) => myUser.password = textPW,
                decoration: const InputDecoration(labelText: "비밀번호"),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (textName) => myUser.name = textName,
                decoration: const InputDecoration(labelText: "이름"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (textPhone) => myUser.phoneNumber = textPhone,
                    decoration: const InputDecoration(labelText: "전화번호"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  child: Text(
                    '인증번호 전송',
                    style: kElevatedButtonTextStyle,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
                  ),
                  onPressed: () {
                    String checkPhone = myUser.phoneNumber;
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('니 전화번호~'),
                          content: Text('$checkPhone'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('수고!'),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      //To change state here
                    });
                  },
                ),
              ),
            ],
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                //onChanged: (textAuthen) => authenticationCode = textAuthen,
                decoration: const InputDecoration(labelText: "인증번호"),
              ),
            ),
          ),
          SizedBox(
            height: 175.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                side: MaterialStateProperty.all(BorderSide(
                  color: Color(0xFF89A1F8),
                  width: 2.0,
                )),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '두잇처치 시작하기',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF89A1F8),
                  ),
                ),
              ),
              onPressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: myUser.email, password: myUser.password);

                  //CollectionReference member = FirebaseFirestore.instance.collection('member');
                  firestore.collection('member').add({
                    'email': myUser.email,
                    'name': myUser.name,
                    'password': myUser.password,
                    'phone_num': myUser.phoneNumber
                  });

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
                print(myUser.email);
                print(myUser.password);
                print(myUser.name);
                print(myUser.phoneNumber);
                setState(() {
                  //To change state here
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
