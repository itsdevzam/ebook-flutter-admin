import 'package:ebook_admin/utils/colors.dart';
import 'package:flutter/material.dart';

class MyHeading extends StatelessWidget {
  String text;
  double? fontSize;
  Color? color;
  double? wordSpacing;
  MyHeading({super.key, required this.text, this.fontSize, this.color,this.wordSpacing});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 30,
        fontWeight: FontWeight.bold,
        wordSpacing: wordSpacing ?? 0,
        color: color ?? Colors.black,
      ),
    );
  }
}
