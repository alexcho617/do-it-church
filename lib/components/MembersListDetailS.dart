import 'package:do_it_church/components/customUser.dart';
import 'package:do_it_church/screens/member_info_detail_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScreenDivider.dart';


class MembersListDetailS extends StatelessWidget {
  // const MembersList(this._customUser);
  // final CustomUser _customUser;
  Map<String, dynamic> data =
  {
    "image": "images/kid.jpg",
    "name": "강지담 학생",
    "categories": "010-1122-3344",
  };




  @override
  Widget build(BuildContext context) {
    return ListTile(
      //contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: CircleAvatar(
        backgroundImage: AssetImage(
            data["image"]), //always add images in directory
        radius: 20,
      ),
      title: Text(
        data["name"],style: TextStyle(fontWeight: FontWeight.bold),),
      //title: Text(_customUser.name),
      //subtitle: Text("${_customUser.birthdate}"),
      subtitle:Text(
          data["categories"]),
      trailing:Column(
        children: [
          SizedBox(
            height: 25,
            width: 80,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemberInfoDetailListRoute()),
                );
              },
              child: Text('심방정보', style: TextStyle(fontSize: 13)),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 25,
            width: 80,
            child: OutlinedButton(
              onPressed: () {

              },
              child: Text('수정하기', style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );

  }
}