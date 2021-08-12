import 'package:do_it_church/screens/notice_new.dart';
import 'package:flutter/material.dart';
import 'notice_new.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoticeDetail extends StatefulWidget {
  const NoticeDetail({Key? key}) : super(key: key);

  @override
  NoticeDetailState createState() => NoticeDetailState();
}

class NoticeDetailState extends State<NoticeDetail> {
  // 텍스트필드 제어용 컨트롤러
  TextEditingController _textEditingController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print(
            'SUCCESS(notice_detail_screen): Signed in As:${loggedInUser.phoneNumber}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'notice detail',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
<<<<<<< HEAD
          title: Center(
            child: Text('공지사항보기',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
=======
          title: Text(
            '공지목록보기',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
>>>>>>> 0c86d4fd5b6988771a6b6d2d7810f0b352b75c0a
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              }),
          leadingWidth: 20,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.create_rounded,
                  color: Color(0xFF89A1F8),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoticeAddRoute()),
                  );
                  setState(() {});
                }),
          ],
        ),
<<<<<<< HEAD
//listview사용하기
=======
>>>>>>> 0c86d4fd5b6988771a6b6d2d7810f0b352b75c0a
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: ListTile(
                    leading: Icon(Icons.menu),
                    title: Text(
                      '6월 생일잔치 알려드립니다.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '2021년 6월 30일, 박강두 전도사',
                      style: TextStyle(fontSize: 10),
                    )),
              ),

              Container(
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Text(
                  '6월 생일자 : 김세희, 박효인, 최다운 \n준비팀 : 고은혜T, 고은미T, 박한동T \n\n 준비 열심히 해서 재밌게 진행해봅시다! 각 반의 선생님들께서는 아이들에게 생일잔치에 대한 문자 메세지를 하루 전 날에 꼬옥 보내주세요!\n\n**공지를 확인하신 선생님들은 댓글창에 "확인완료" 혹은 "확인했습니다"라고 댓글 부탁드려요~',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(4.0),
                color: Colors.white38,
                child: OutlineButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {},
                  icon: Icon(
                    Icons.share,
                    color: Colors.blueAccent,
                  ),
                  label: Text('공유하기'),
                ),
                margin: const EdgeInsets.only(left: 10),
              ),

              //구분선 만들기
              Container(
                height: 1.0,
                width: 500.0,
                color: Colors.black38,
              ),

              Container(
                color: Colors.white38,
                child: ListTile(
                    //CircleAvatar() , use images from the images folder
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/pro.jpg'), //always add images in directory
                      maxRadius: 15,
                    ),
                    title: Text(
                      '김은희(소망반)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      '확인완료했습니다! 이번에도 즐겁게!',
                      style: TextStyle(fontSize: 13),
                    )),
              ),

              Container(
                color: Colors.white38,
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/pro1.png'), //always add images in directory
                      maxRadius: 15,
                    ),
                    title: Text(
                      '박세미(다윗반)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      '확인완료했습니다! 잘 준비합시다',
                      style: TextStyle(fontSize: 13),
                    )),
              ),

              Container(
                color: Colors.white38,
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/pro2.jpg'), //always add images in directory
                      maxRadius: 15,
                    ),
                    title: Text(
                      '고은미(사랑반)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      '확인완료했습니다! 늘 신경써주셔서 감사해요!',
                      style: TextStyle(fontSize: 13),
                    )),
              ),

              Container(
                color: Colors.white38,
                child: ListTile(
                    //CircleAvatar() , use images from the images folder
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/pro3.jpg'), //always add images in directory
                      maxRadius: 15,
                    ),
                    title: Text(
                      '김말희(믿음반)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      '확인완료~ 늘 수고가 많으세요:) 화이팅!',
                      style: TextStyle(fontSize: 13),
                    )),
              ),

              Container(
                color: Colors.white38,
                child: ListTile(
                    //CircleAvatar() , use images from the images folder
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/pro4.jpg'), //always add images in directory
                      maxRadius: 15,
                    ),
                    title: Text(
                      '박준기(기쁨반)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      '확인완료 항상 기도하고 있습니다!',
                      style: TextStyle(fontSize: 13),
                    )),
              ),

//댓글창 만들기
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
<<<<<<< HEAD
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        //style:TextStyle(height:0.01, fontSize: 12),

                        controller: _textEditingController,
                        decoration: InputDecoration(hintText: "댓글 입력창"),
                        onSubmitted: _handleSubmitted,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
=======
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      //style:TextStyle(height:0.01, fontSize: 12),
                      controller: _textEditingController,
                      decoration: InputDecoration(hintText: "댓글 입력창"),
                      onSubmitted: _handleSubmitted,
>>>>>>> 0c86d4fd5b6988771a6b6d2d7810f0b352b75c0a
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  FlatButton(
                    onPressed: () {
                      _handleSubmitted(_textEditingController.text);
                    },
                    child: Text("완료"),
                    color: Colors.blueAccent,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _handleSubmitted(String text) {
  print(text);
  //_textEditingController.clear();
}
