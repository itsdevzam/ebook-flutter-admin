import 'package:ebook_admin/utils/colors.dart';
import 'package:flutter/material.dart';

class MyRectangleButton extends StatelessWidget {
  String label;
  double? height;
  double? width;
  Color? bgColor,textColor;
  VoidCallback callback;
  MyRectangleButton({super.key,required this.label,this.width,this.height,required this.callback,this.bgColor,this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??40,
      width: width??120,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor??Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(5),
          )
        ),
        onPressed: callback,
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold,color: textColor??ThemeColors.primaryColor),
        ),
      ),
    );
  }
}
