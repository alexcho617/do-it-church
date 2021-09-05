import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  final List<String> categories = ['전체보기', '교사', '학생'];

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.only(left:10.0),
      height: 40.0,
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
            child:Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: index == selectedIndex ? Color(0xFF89A1F8) : Colors.black38,
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
