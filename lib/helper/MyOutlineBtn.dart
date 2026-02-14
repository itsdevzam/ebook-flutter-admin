import 'package:flutter/material.dart';

class MyOutlineBtn extends StatelessWidget {
  String label;
  double? height;
  double? width;
  VoidCallback callback;
  MyOutlineBtn({super.key,required this.label,this.width,this.height,required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??40,
      width: width??120,
      child: OutlinedButton(
        onPressed: callback,
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
