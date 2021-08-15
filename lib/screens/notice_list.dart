import 'package:do_it_church/constants.dart';
import 'package:do_it_church/screens/landing_route.dart';
import 'package:do_it_church/screens/notice_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'notice_detail.dart';
import 'notice_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:like_button/like_button.dart';

class NoticeListRoute extends StatefulWidget {
  @override
  _NoticeListRouteState createState() => _NoticeListRouteState();
}

class _NoticeListRouteState extends State<NoticeListRoute> {
  final _auth = FirebaseAuth.instance;
  //User loggedInUser; //getting error
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print(
            'SUCCESS(notice_list_screen): Signed in As:${loggedInUser.phoneNumber}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  final List<String> NoticeTitle = ["6월 생일잔치 세부사항", "온라인 예배공지", "사랑하는 주일학교 학부모님들께", "달란트시장 일정 공지"];
  final List<String> NoticeSubTitle = ["2021년 6월 30일, 박강두 전도사", "2021년 6월 19일, 김신의 전도사", "2021년 6월 14일, 김신의 전도사", "2021년 6월 8일, 박한동 선생님"];
  final List<String> NoticeContent = ['6월 생일자: 김세희, 박효인, 최다운\n준비팀: 고은혜T, 고은미T, 박현동T\n준비 열심히 해서 재밌게 진행해봅시다! 각 반의 선생님들께서는 아이들에게 생일잔치에 대한 문자 메세지를 하루 전 날에 꼬옥 보내주세요!',
  '이번주 온라인 예배는 줌으로 진행할 예정입니다.\n 가만히 앉아서 말씀만 듣는게 아니라, 모두 다 소리를 켜고 말씀에 대해 나눔하는 시간과 교제하는 시간을 가질 예정이오니 미리 준비하시기 바랍니다.',
  '안녕하세요. 김신의 전도사입니다.\n다들 무더운 여름 잘 보내고 계신가요? 다름이 아니고 학부모님들께 몇 가지 당부의 말씀 드리고자 공지를 올렸습니다. 이번 코로나 사태를 통해',
  '안녕하십니까? 벌써 6월이 되었습니다.\n이번달 셋째 주 일요일인 6월 20일 예배 후 달란트 시장이 열릴 예정입니다. 자녀분이 가지고 있는 달란트 금액은 홈화면 상단의 아이콘에서 확인하실 수 있습니다.'];
  List<int> NoticeView = [10, 35, 42, 45];
  List<int> NoticeComment = [4, 10, 24, 20];
  List<bool> isLiked = [false, false, false, false];
  List<int> likeCount = [10, 15, 20, 30];
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    // final size = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '공지사항',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              setState(() {
                //
              });
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
      body: Center(
        child: ListView.builder(
          itemCount: NoticeTitle.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoticeDetail()),
                );
                setState(() {});
              },
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffE5E5E5),
                      width: 4.0,
                    ),
                  ),
                ),
                //width: size,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.notes_rounded,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${NoticeTitle[index]}',
                                      style: kNoticeTitleTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      //날짜 + 작성자 서버에서 받아서 변수로 출력
                                      '${NoticeSubTitle[index]}',
                                      style: kNoticeSubTitleTextStyle,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          text: TextSpan(
                                              text:
                                              '${NoticeContent[index]}',
                                              style: kNoticeContentTextStyle),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(Icons.more_horiz, color: Colors.black),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: Text('글 수정하기'),
                                      ),
                                      ListTile(
                                        title: Text('공유하기'),
                                      ),
                                      ListTile(
                                        title: Text('삭제하기'),
                                      ),
                                    ],
                                  );
                                });
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 12,
                          color: Colors.grey,
                        ),
                        Container(
                          width: 5,
                        ),
                        Text('${NoticeView[index]}', style: kNoticeCountTextStyle),
                        Container(
                          width: 10,
                        ),
                        Icon(Icons.chat_outlined, size: 12, color: Colors.grey),
                        Container(
                          width: 5,
                        ),
                        Text('${NoticeComment[index]}', style: kNoticeCountTextStyle)
                      ],
                    ),
                    Container(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          //ElevatedButton, OutlinedButton
                          child: SizedBox(
                            height: 27,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero
                              ),
                              onPressed: () async {},
                              child: LikeButton(
                                isLiked: isLiked[index],
                                likeCount: likeCount[index],
                                likeBuilder: (isLiked){
                                  final color = isLiked ? Colors.red : Colors.grey;

                                  return Icon(Icons.favorite, color: color, size: 13);
                                },
                                likeCountPadding: EdgeInsets.zero,
                                countBuilder: (count, isLiked, text) {
                                  final color = isLiked ? Color(0xFF89A1F8) : Colors.grey;

                                  return Text(
                                    text,
                                    style: TextStyle(fontSize: 13, color: color),
                                  );
                                },
                                onTap: (isLiked) async{
                                  this.isLiked[index] = !isLiked;
                                  likeCount[index] += this.isLiked[index] ? 1 : -1;

                                  return !isLiked;
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 27,
                            child: OutlinedButton(
                              onPressed: () {
                              },
                              child:
                              Text('댓글쓰기', style: TextStyle(fontSize: 13)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
