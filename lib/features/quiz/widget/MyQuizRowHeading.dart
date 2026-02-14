import 'package:ebook_admin/helper/MyHeading.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class MyQuizRowHeading extends StatelessWidget {
  const MyQuizRowHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(width: 30),
              // SizedBox(width: 15),
              // SizedBox(
              //   width: Constants.isDesktop(context)?120:80,
              //   child: MyHeading(text: "Name", fontSize: 17),
              // ),
              SizedBox(width: 10),
              MyHeading(text: "Quiz", fontSize: 17),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: Constants.isDesktop(context)?200:100,child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: MyHeading(text: "Category", fontSize: 17),
              )),
              MyHeading(text: "Edit", fontSize: 17),
              MyHeading(text: "Delete", fontSize: 17),
            ],
          ),
        ),
      ],
    );
  }
}
