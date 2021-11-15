import 'package:do_it_church/components/teacher.dart';
import 'package:do_it_church/components/teacherRepository.dart';
import 'package:do_it_church/screens/member_info_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'teacher.dart';
import 'teacherRepository.dart';

//교적관리 교사 리스트 화면입니다.

class MembersList extends StatelessWidget {
  // const MembersList(this._customUser);
  //  final CustomUser _customUser;

  @override
  Widget build(BuildContext context) {
    final List<Teacher> allTeacherInformation = allTeachers;

    for (var teacher in allTeacherInformation) {
      print(teacher.name);
      print(teacher.address);
      print(teacher.phoneNumber);
      print(teacher.department);
    }


      return ListTile(
        //content Padding: EdgeInsets.symmetric(horizontal: 20),
        leading: CircleAvatar(
          backgroundImage:
          AssetImage('images/pro.jpg'), //always add images in directory
          radius: 20,
        ),

        // '${allTeacherInformation[0].name.toString()'}
        // style: TextStyle(fontWeight: FontWeight.bold),

        title: Text('${allTeacherInformation[0].name}',
        style: TextStyle(fontWeight: FontWeight.bold)) ,

        //title: Text(_customUser.name),
        //subtitle: Text("${_customUser.birthdate}"),
        subtitle: Text('${allTeacherInformation[0].role}'),
        trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MemberInfoDetailRoute()),
              );
            },
            icon: Icon(Icons.arrow_forward_ios)),
      );
    }
  }

