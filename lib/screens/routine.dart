
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class RoutineRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('하루 양육 루틴', style: kAppBarTitleTextStyle),
        ),
        body: Center(
          child:CheckBoxInListView(),
        )
    );
  }
}

class CheckBoxInListView extends StatefulWidget {
  //CheckBoxInListView({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<CheckBoxInListView> {
  //bool _isChecked = false;

  List<String> _texts = [
    '(아침에 일어나서) "엄마(아빠)는 두잇이가 도와줘서 너무 고마워!"라고 이야기며 하루를 시작해보는 것은 어떨까요? 구체적인 예시를 함께 얘기해주면 더 좋아요.',
    "(등하교할 때) 차로 데려다주는 길에 슬쩍 한번 물어보세요! '두잇이 친구 중에 어떤 친구가 두잇이를 많이 웃게 해? 두잇이는 친구들을 행복하게 해주는 친구인 것 같아?'",
    "(식사시간) 식탁을 둘러앉은 가족들이 번갈아가면서 삶 속에서 감사했던 순간들에 대해 이야기해보는 건 어떨까요?",
    "(잠들기 전에) 서로를 위해 기도해주세요! '하나님, 저희에게 주신 모든 것에 감사드립니다.' 하나님이 여러분의 가족을 위해 하신 일들을 하나하나 이야기하며 잠에 드는 건 어떨까요?",

  ];

  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
            itemCount: _texts.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      children: [
                        Container(
                          height: 5,
                          color: Colors.grey,
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.all(20),
                         title:
                            Text(_texts[index],maxLines:10, style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.w500) ),
                          value: _isChecked[index],
                          onChanged: (val) {
                            setState(
                                  () {
                                _isChecked[index] = val!;
                                print(index);
                              },
                            );
                          },
                        ),
             ] ),
                   );
            },
          ),
        ),
      ),
    );
  }
}