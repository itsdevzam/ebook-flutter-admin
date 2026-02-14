import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String text;
  double? fontSize;
  bool? isOverFlow;
  int? maxLines;
  FontWeight? fontWeight;
  MyText({super.key,required this.text,this.fontSize,this.isOverFlow,this.maxLines,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    TextStyle style1 = TextStyle(
      fontWeight: fontWeight??FontWeight.normal,
        overflow: TextOverflow.ellipsis,
        fontSize: fontSize??14,
    );
    TextStyle style2 = TextStyle(
        fontWeight: fontWeight??FontWeight.normal,
        fontSize: fontSize??14
    );
    return Text(
      maxLines: maxLines??1,
      text,
      style: isOverFlow==true?style1:style2,
    );
  }
}