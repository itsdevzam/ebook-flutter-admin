import 'package:ebook_admin/helper/MyHeading.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  String title1,title2;
  MyCard({super.key,required this.title1,required this.title2});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      width: 200,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyHeading(text: title1,color: Colors.white,),
          MyHeading(text: title2,color: Colors.white,),
        ],
      ),
    );
  }
}
