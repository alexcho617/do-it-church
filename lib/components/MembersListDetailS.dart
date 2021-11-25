import 'package:do_it_church/components/customUser.dart';
import 'package:do_it_church/components/student.dart';
import 'package:do_it_church/components/studentRepository.dart';
import 'package:do_it_church/screens/member_info_detail_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScreenDivider.dart';


class MembersListDetailS extends StatelessWidget {
  final List<Student> allStudentInformation = allStudents;




  @override
  Widget build(BuildContext context) {
    return ListTile(
      //contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: CircleAvatar(
        backgroundImage: AssetImage(
            "images/kid.jpg"), //always add images in directory
        radius: 20,
      ),
      title: Text(
          '${allStudentInformation[0].name}${allStudentInformation[0].role}',style: TextStyle(fontWeight: FontWeight.bold),
      ),
      //title: Text(_customUser.name),
      //subtitle: Text("${_customUser.birthdate}"),
      subtitle:Text(
        '${allStudentInformation[0].phoneNumber}'),
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