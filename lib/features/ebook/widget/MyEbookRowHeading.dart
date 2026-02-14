import 'package:ebook_admin/helper/MyHeading.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class MyEbookRowHeading extends StatelessWidget {
  const MyEbookRowHeading({super.key});

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
              SizedBox(width: 15),
              SizedBox(
                width: Constants.isDesktop(context)?120:80,
                child: MyHeading(text: "Image", fontSize: 17),
              ),
              SizedBox(width: 10),
              MyHeading(text: "Title", fontSize: 17),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyHeading(text: "Category", fontSize: 17),
              MyHeading(text: "Edit", fontSize: 17),
              MyHeading(text: "Delete", fontSize: 17),
            ],
          ),
        ),
      ],
    );
  }
}
