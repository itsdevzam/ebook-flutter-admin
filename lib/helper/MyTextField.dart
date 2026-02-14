import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String label;
  double? width;
  int? maxlines;
  bool? enable;
  TextEditingController textEditingController;
  MyTextField({super.key,required this.label,this.width,required this.textEditingController,this.maxlines,this.enable});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: width??400,
      child: TextField(
        maxLines: maxlines??1,
        controller: textEditingController,
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(),
        ),
        enabled: enable??true,
      ),
    );
  }
}
