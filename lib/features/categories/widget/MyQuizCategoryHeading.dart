import 'package:ebook_admin/helper/MyHeading.dart';
import 'package:flutter/material.dart';

class MyQuizCategoryHeading extends StatelessWidget {
  const MyQuizCategoryHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(width: 50),
              // SizedBox(width: 15),
              // SizedBox(
              //   width: Constants.isDesktop(context)?120:80,
              //   child: MyHeading(text: "Name", fontSize: 17),
              // ),
              SizedBox(width: 10),
              MyHeading(text: "Category", fontSize: 17),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyHeading(text: "SubCat", fontSize: 17),
              MyHeading(text: "Edit", fontSize: 17),
              MyHeading(text: "Delete", fontSize: 17),
            ],
          ),
        ),
      ],
    );
  }
}
