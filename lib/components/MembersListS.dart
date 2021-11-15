
import 'package:do_it_church/screens/member_info_detail_s.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'student.dart';
import 'studentRepository.dart';


//교적관리 교사 리스트 화면입니다.


class MembersListS extends StatelessWidget {

  Map<String, dynamic> data =
  {
    "image": "images/kid.jpg",
    "name": "강지담",
    "categories": "학생",
  };


  @override
  Widget build(BuildContext context) {
    final List<Student> allStudentInformation = allStudents;

    for (var student in allStudentInformation) {
      print(student.name);
      print(student.address);
      print(student.phoneNumber);
      print(student.department);
    }

    return ListTile(
      //contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: CircleAvatar(
        backgroundImage: AssetImage(
            data["image"]), //always add images in directory
        radius: 20,
      ),
      title: Text(
          '${allStudentInformation[0].name}',
        style: TextStyle(fontWeight: FontWeight.bold),),
      //title: Text(_customUser.name),
      //subtitle: Text("${_customUser.birthdate}"),
      subtitle:Text(
        '${allStudentInformation[0].role}'),
      trailing: IconButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemberInfoDetailSRoute()),
        );
        }, icon: Icon(Icons.arrow_forward_ios)),
    );
  }
}