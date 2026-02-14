import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'MyHeading.dart';
import 'MyRectangleButton.dart';
import 'MyTextField.dart';

class MySearchLayout extends StatelessWidget {
  TextEditingController textEditingController;
  String heading;
  VoidCallback searchCallback;
  bool? isSearchEnable;
  IconData iconData;
  String searchLabel;
  MySearchLayout({super.key,required this.textEditingController,required this.heading,required this.searchCallback,required this.iconData,this.isSearchEnable,required this.searchLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Constants.isDesktop(context)
              ? MyHeading(text: heading)
              : CircleAvatar(
            backgroundColor: ThemeColors.primaryColor,
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
        isSearchEnable==false?SizedBox():Row(
          children: [
            MyTextField(
              label: searchLabel,
              textEditingController: textEditingController,
              width: Constants.isDesktop(context) ? 400 : 200,
            ),
            SizedBox(width: 1),
            MyRectangleButton(
              label: "Search",
              callback: searchCallback,
              height: 48,
              width: Constants.isDesktop(context) ? 120 : 100,
            ),
            SizedBox(
              width: Constants.isDesktop(context) ? 100 : 20,
            ),
          ],
        ),
      ],
    );
  }
}
