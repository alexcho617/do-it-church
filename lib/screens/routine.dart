
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../constants.dart';




class RoutineRoute extends StatefulWidget {
  @override
  RoutineDemoState createState() => new RoutineDemoState();
}

class RoutineDemoState extends State<RoutineRoute> {
  List<CheckBoxListTileModel> checkBoxListTileModel =
  CheckBoxListTileModel.getUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('하루 양육 루틴', style: kAppBarTitleTextStyle),
        ),

        body: new ListView.builder(
            itemCount: checkBoxListTileModel.length,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                child: new Container(
                  padding: new EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      new CheckboxListTile(
                          activeColor: Colors.indigoAccent,
                          dense: true,
                          //font change
                          title: new Text(
                            checkBoxListTileModel[index].title,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          subtitle: new Text(
                            checkBoxListTileModel[index].subtitle,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          value: checkBoxListTileModel[index].isCheck,
                          secondary: Container(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              checkBoxListTileModel[index].img,
                              fit: BoxFit.cover,
                            ),
                          ),
                      onChanged: (val) {
                        itemChange(val!, index);
                      })
                      ],
                  ),
                ),
              );
            }),
      );
    }

///체크박스 구현
    void itemChange(bool val, int index) {
      setState(() {
        checkBoxListTileModel[index].isCheck = val;
      });
    }
  }

  //양육루틴 내용만들기

  class CheckBoxListTileModel {
    int userId;
    String img;
    String title;
    String subtitle;
    bool isCheck;

    CheckBoxListTileModel({required this.userId, required this.img, required this.title, required this.subtitle, required this.isCheck, });

    static List<CheckBoxListTileModel> getUsers() {
      return <CheckBoxListTileModel>[
        CheckBoxListTileModel(
            userId: 1,
            img: 'images/routine1.png',
            title: "아침에 일어나서",
            subtitle:"'엄마(아빠)는 두잇이가 도와줘서 너무 고마워'라고 이야기하며 하루를 시작해보는 것은 어떨까요? 구체적인 예시를 함께 얘기해주면 더 좋아요.",

            isCheck: false),

        CheckBoxListTileModel(
            userId: 2,
            img: 'images/routine2.png',
            title: "등하교할 때",
            subtitle:"차로 데려다주는 길에 슬쩍 한번 물어보세요! '두잇이 친구 중에 어떤 친구가 두잇이를 많이 웃게 해? 두잇이는 친구들을 행복하게 해주는 친구인 것 같아?'",
            isCheck: false),
        CheckBoxListTileModel(
            userId: 3,
            img: 'images/routine3.png',
            title: "식사시간에",
            subtitle:"식탁을 둘러앉은 가족들이 번갈아가면서 삶 속에서 감사했던 순간들에 대해 이야기해보는 건 어떨까요?",
            isCheck: false),
        CheckBoxListTileModel(
            userId: 4,
            img: 'images/routine4.png',
            title: "잠들기 전에",
            subtitle:"서로를 위해 기도해주세요! '하나님, 오늘도 함께하시니 감사합니다.' 오늘 하루 하나님께 감사한 점을 하나하나 이야기하며 잠에 드는 건 어떨까요?",
            isCheck: false),
           ];
    }
}