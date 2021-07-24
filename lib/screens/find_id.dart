import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class FindId extends StatefulWidget{
  @override
  _FindIdState createState() => _FindIdState();
}

class _FindIdState extends State<FindId>{

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      print('아이디 찾기 탭');
                    });// Respond to button press
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
                    });// Respond to button press
                  },
                  child: Text("비번도 몰라..?",
                    style: TextStyle(color: Color(0xffB6B6B6)),),
                ),
              ),
            ],
          ),
         Text(
                '등록된 휴대폰 번호로 찾기',
                textAlign: TextAlign.left,
                style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, ),
              ),
          Text(
                '가입 당시 입력했던 휴대전화를 통해 인증하세요!',
                textAlign: TextAlign.left,
                style: TextStyle(color: const Color(0xff404040), ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 30, left: 10, right: 10),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '01012345678'
              ),
              onChanged: (value) { },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30.0, bottom: 100),
            child: ElevatedButton(
              child: Text('아이디 찾기', style: TextStyle(color: Colors.white),),
              onPressed: (){
                setState(() {
                  print('아이디 찾기 버튼 누름');
                });
                },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 100.0, bottom: 30),
            child: InkWell(
                child: Image.asset('images/backtologinbtn.png', width: 280, height: 40),
                onTap: () => print('로그인 페이지로 돌아가')
            ),
          ),
        ],
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}