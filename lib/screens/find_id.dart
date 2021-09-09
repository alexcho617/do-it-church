import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_it_church/constants.dart';
import '../View/login.dart';

class FindId extends StatefulWidget {
  @override
  _FindIdState createState() => _FindIdState();
}

class _FindIdState extends State<FindId> {
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
        title: Text('아이디/비번 찾기'),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      print('아이디 찾기 탭');
                    }); // Respond to button press
                  },
                  child: Text("니 아이디도 모르나",
                      style: TextStyle(color: Color(0xff89A1F8))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      print('비밀번호 찾기 탭');
                    }); // Respond to button press
                  },
                  child: Text(
                    "비번도 몰라..?",
                    style: TextStyle(color: Color(0xffB6B6B6)),
                  ),
                ),
              ),
            ],
          ),
          Text(
            '등록된 휴대폰 번호로 찾기',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '가입 당시 입력했던 휴대전화를 통해 인증하세요!',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: const Color(0xff404040),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: '01012345678'),
              onChanged: (value) {},
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF89A1F8)),
                side: MaterialStateProperty.all(
                    BorderSide(color: Color(0xFF89A1F8))),
                // shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30.0))),
              ),
              child: Text(
                '아이디 찾기',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                print('아이디 찾기 버튼 누름');
                setState(() {});
              },
            ),
          ),
          SizedBox(
            height: 300.0,
          ),
          Container(
            child: ElevatedButton(
              //이 스타일을 사용, constants 파일에 정의 되어있음, 하지만 직접 복사해서 써야함
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                side: MaterialStateProperty.all(
                    BorderSide(color: Color(0xFF89A1F8))),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
              ),
              child: Text(
                '로그인 페이지로 돌아가기',
                style: TextStyle(
                  color: Color(0xFF89A1F8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}
