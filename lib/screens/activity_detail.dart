import 'package:flutter/material.dart';
import 'package:do_it_church/components/colors.dart' as color;
import '../constants.dart';

class ActivityDetailRoute extends StatefulWidget {
  const ActivityDetailRoute({Key? key}) : super(key: key);

  @override
  _ActivityDetailRouteState createState() => _ActivityDetailRouteState();
}

class _ActivityDetailRouteState extends State<ActivityDetailRoute> {
  @override
  Widget build(BuildContext context) {
  // deviceHeight = MediaQuery.of(context).size.height;
  // deviceWidth = MediaQuery.of(context).size.width;

  return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Text('활동가이드', style: kAppBarTitleTextStyle),
  ),
      body: ListView(

        padding: const EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
            InkWell(
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      width:MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(8),
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
                      height:500,
                      width: 150,
                      margin: const EdgeInsets.only(left:20, right:160,top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image:DecorationImage(
                            image: AssetImage(
                                "images/coin.png",
                            ),
                            fit: BoxFit.contain
                        ),

                      ),
                    ),


                    Container(
                      width: double.maxFinite,
                      height: 100,
                      margin: const EdgeInsets.only(left: 190, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "포항제일교회",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                            ),
                          ),

                          SizedBox(height:3),
                          Text("빛나는 동전과 구원",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height:15),

                          RichText(text: TextSpan(
                            text:"#구원 #죄사함 #감사",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          )),],
                      ),
                    )
                  ],
                ),
              ),

            ),
            CategoryActivity(),

            Container(
              height: MediaQuery.of(context).size.height,
              color: Color(0xffEBEEFD),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),

                      child: Column(

                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children:<Widget>[
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("본문 말씀",
                              style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),textAlign: TextAlign.start,),
                              SizedBox(width: 90,),
                              Text("누가복음 15: 8 -10 ",
                              style: TextStyle(
                                    fontSize: 13,
                                    
                                    color: Colors.black,
                              ),textAlign: TextAlign.justify,),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("준비물",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),textAlign: TextAlign.start,),
                              SizedBox(width: 40,),
                              Text("더러운 동전, 베이킹소다, 천, 물",
                                style: TextStyle(
                                  fontSize: 13,

                                  color: Colors.black,
                                ),textAlign: TextAlign.center,),
                            ],
                          ),
                          SizedBox(height: 30,),

                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("내용",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),),
                              SizedBox(width: 40,),
                              Text(
                                "성경은 우리가 하나님으로부터....",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],),
                  ),


                  Container(
                    margin: const EdgeInsets.only(top:5,left:20,right:20,),
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.height)-300,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),

                    child: Column(

                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget>[
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                                image: AssetImage(
                                  "images/coin1.png",
                                ),
                                fit: BoxFit.contain
                            ),

                            Text("1.먼저아이들에게 동전을 ",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),),
                          ],
                        ),
                  

                      ],),
                  ),
                ],


              ),
            ),],
      ),
  );

  }
}
class CategoryActivity extends StatefulWidget {
  @override
  _CategoryActivityState createState() => _CategoryActivityState();
}

class _CategoryActivityState extends State<CategoryActivity> {
  int selectedIndex = 0;
  final List<String> categories = ['활동설명','리뷰'];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left:50, right: 60,top: 10, bottom: 10),
        height: 50.0,
        color: Colors.white,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    }
                    );
                  },
                  child:Padding(padding: EdgeInsets.symmetric(horizontal:50.0),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: index == selectedIndex ? Color(0xFF89A1F8) : Colors.black54,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ));
            }
        )
    );
  }
}