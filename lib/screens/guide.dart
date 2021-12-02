import 'package:do_it_church/screens/routine.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:do_it_church/components/colors.dart' as color;

class GuideRoute extends StatefulWidget {
  @override
  _GuideRouteState createState() => _GuideRouteState();
}

class _GuideRouteState extends State<GuideRoute> {
  final _auth = FirebaseAuth.instance;

  //User loggedInUser; //getting error
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        User loggedInUser = user;
        print(
            'SUCCESS(guide_screen): Signed in As:${loggedInUser.phoneNumber}');
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
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery.of(context);
    // final size = mediaQuery.size.width;
    return Scaffold(

          backgroundColor: color.AppColor.homePageBackground,
          body:SingleChildScrollView(
          child:Container(
              padding: const EdgeInsets.only(top:70, left:20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "활동가이드",
                            style: TextStyle(
                                fontSize: 25,
                                color: color.AppColor.homePageTitle,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.apps,
                              size: 20,
                              color: color.AppColor.homePageSubtitle),
                          TextButton(onPressed: (){}, child: Text("카테고리",
                              style: TextStyle(
                                  color: color.AppColor.homePageTitle,
                                  fontWeight: FontWeight.w700
                              )),)
                        ],
                      ),
                        Column(
                            children: [
                            SizedBox(height: 30,),
                            Row(
                              children: [
                                Text(
                                  "이번주 BEST 활동",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: color.AppColor.homePageSubtitle,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  "더보기",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: color.AppColor.homePageDetail,

                                  ),
                                ),
                                SizedBox(width: 5,),
                                Icon(Icons.arrow_forward,
                                  size: 20,
                                  color: color.AppColor.homePageTitle,
                                ),

                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 180,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        color.AppColor.gradientFirst.withOpacity(0.8),
                                        color.AppColor.gradientSecond.withOpacity(0.9),
                                      ],
                                      begin:Alignment.bottomLeft,
                                      end: Alignment.centerRight
                                  ),
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(80)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset:Offset(5,10),
                                      blurRadius: 10,
                                      color: color.AppColor.gradientSecond.withOpacity(0.2),
                                    )
                                  ]
                              ),

                        //하루양육루틴

                            child:Container(
                              padding: const EdgeInsets.only(left: 20, top:25,right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "포항제일교회",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: color.AppColor.homePageBackground
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "빛나는 동전과 구원",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        color: color.AppColor.homePageBackground
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "#구원 #감사 #죄사함",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: color.AppColor.homePageBackground
                                    ),
                                  ),
                                  SizedBox(height: 10),


                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.timer, size:18, color:color.AppColor.homePageBackground),
                                          SizedBox(width:8,),
                                          Text(
                                            "소요시간: 30분",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: color.AppColor.homePageBackground
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(60),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: color.AppColor.gradientFirst,
                                                  blurRadius: 10,
                                                  offset: Offset(4, 8)
                                              )
                                            ]
                                        ),
                                        child: Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white, size:40,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ),
                            SizedBox(height: 20,),
                            Row(
                                children: [
                                InkWell(
                                  child: Text('하루 양육 루틴', style: TextStyle(fontSize: 18,
                                      color: color.AppColor.homePageSubtitle,
                                      fontWeight: FontWeight.w700),),
                                  onTap: () => {},
                                ),
                            ],),
                            SizedBox(height: 15,),


                            InkWell(
                              child: Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Container(
                                      width:MediaQuery.of(context).size.width,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.all(Radius.circular(10),
                                        ),
                                          boxShadow: [
                                            BoxShadow(
                                              offset:Offset(8,10),
                                              blurRadius: 40,
                                              color: color.AppColor.gradientSecond.withOpacity(0.2),
                                            ),
                                            BoxShadow(
                                              offset:Offset(-1,-5),
                                              blurRadius: 10,
                                              color: color.AppColor.gradientSecond.withOpacity(0.2),
                                            )
                                          ]
                                      ),
                                    ),
                                    Container(
                                      height:130,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(right:190, bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                            image:DecorationImage(
                                              image: AssetImage(
                                                "images/child2.png"
                                              ),
                                                fit: BoxFit.contain
                                          ),

                                      ),
                                    ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 100,
                                    margin: const EdgeInsets.only(left: 150, top: 50),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "엄마와 아이가 행복한 하루!",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: color.AppColor.homePageDetail
                                          ),
                                        ),
                                        SizedBox(width:10),
                                        RichText(text: TextSpan(
                                          text:"하루 양육을 시작해보세요",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black38,
                                          ),
                                        )),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          margin: EdgeInsets.only(right:20),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size:20,
                                            color:Colors.black38,
                                          ),
                                        )],
                                    ),
                                  )
                                ],
                              ),
                          ),
                              onTap: () => {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RoutineRoute()),
                              )},
                            ),

                                  Row(
                                    children: [
                                      Text(
                                        "카테고리",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: color.AppColor.homePageTitle,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15,),

                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 170,
                                            padding: EdgeInsets.only(bottom: 15),
                                            child:Container(
                                                    padding: EdgeInsets.all(15),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white70,
                                                        borderRadius: BorderRadius.circular(10),
                                                        // image:DecorationImage(
                                                        //   image: AssetImage(
                                                        //       'images/bible.png',
                                                        //   ),
                                                        //   fit: BoxFit.fitHeight,
                                                        // ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset:Offset(8,10),
                                                            blurRadius: 40,
                                                            color: color.AppColor.gradientSecond.withOpacity(0.2),
                                                          ),
                                                          BoxShadow(
                                                            offset:Offset(-1,-5),
                                                            blurRadius: 10,
                                                            color: color.AppColor.gradientSecond.withOpacity(0.2),
                                                          )]),
                                                    child:Center(
                                                        child:Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            "주제별",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18,
                                                              color: color.AppColor.homePageDetail,
                                                            ),
                                                          ),
                                                        )
                                                        ),
    ),
    ),
                                          SizedBox(width:10),
                                          Container(
                                              height: 150,
                                              width: 170,
                                              padding: EdgeInsets.only(bottom: 15),

                                            child:Container(
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius: BorderRadius.circular(10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset:Offset(8,10),
                                                        blurRadius: 40,
                                                        color: color.AppColor.gradientSecond.withOpacity(0.2),
                                                      ),
                                                      BoxShadow(
                                                        offset:Offset(-1,-5),
                                                        blurRadius: 10,
                                                        color: color.AppColor.gradientSecond.withOpacity(0.2),
                                                      )]),
                                                child:Center(
                                                    child:Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        "절기별",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: color.AppColor.homePageDetail,
                                                        ),
                                                      ),
                                                    )
                                                ),
                                              ),
                                          ),]

    ),
                                      Row(
                                          children: [
                                            Container(
                                              height: 150,
                                              width: 170,
                                              padding: EdgeInsets.only(bottom: 15),
                                              child:Container(
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius: BorderRadius.circular(10),
                                                    
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset:Offset(8,10),
                                                        blurRadius: 40,
                                                        color: color.AppColor.gradientSecond.withOpacity(0.2),
                                                      ),
                                                      BoxShadow(
                                                        offset:Offset(-1,-5),
                                                        blurRadius: 10,
                                                        color: color.AppColor.gradientSecond.withOpacity(0.2),
                                                      )]),
                                                child:Center(
                                                    child:Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        "연령별",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: color.AppColor.homePageDetail,
                                                        ),
                                                      ),
                                                    )
                                                ),
                                              ),
                                            ),
                                            SizedBox(width:10),
                                            Container(
                                              height: 150,
                                              width: 170,
                                              padding: EdgeInsets.only(bottom: 15),
                                              child:Container(
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius: BorderRadius.circular(10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset:Offset(8,10),
                                                        blurRadius: 40,
                                                        color: color.AppColor.gradientSecond.withOpacity(0.2),
                                                      ),
                                                      BoxShadow(
                                                        offset:Offset(-1,-5),
                                                        blurRadius: 10,
                                                        color: color.AppColor.gradientSecond.withOpacity(0.2),
                                                      )]),
                                                child:Center(
                                                    child:Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        "프로그램",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          color: color.AppColor.homePageDetail,
                                                        ),
                                                      ),
                                                    )
                                                ),
                                              ),
                                            ),]

                                      ),
                                    ],
                                  )]
    )
    ]
    ))));

  }
}

