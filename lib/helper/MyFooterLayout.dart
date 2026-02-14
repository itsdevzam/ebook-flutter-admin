import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'MyText.dart';

class MyFooterLayout extends StatelessWidget {
  String current,total;
  VoidCallback leftcallback,rightcallback;
  MyFooterLayout({super.key,required this.current,required this.total,required this.leftcallback,required this.rightcallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: leftcallback,
            icon: Icon(Iconsax.arrow_circle_left),
          ),
          SizedBox(width: 20),
          MyText(text: "$current of $total"),
          SizedBox(width: 20),
          IconButton(
            onPressed: rightcallback,
            icon: Icon(Iconsax.arrow_circle_right),
          ),
        ],
      ),
    );
  }
}
