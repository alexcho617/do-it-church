import 'package:do_it_church/components/customUser.dart';
import 'package:do_it_church/screens/member_info_detail_s.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScreenDivider.dart';


class MembersListS extends StatelessWidget {
  // const MembersList(this._customUser);
  // final CustomUser _customUser;
  Map<String, dynamic> data =
  {
      "image": "images/kid.jpg",
      "name": "강지담",
      "categories": "학생",
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
      trailing: IconButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemberInfoDetailSRoute()),
        );
      }, icon: Icon(Icons.arrow_forward_ios)),
    );

  }
}
