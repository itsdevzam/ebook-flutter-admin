import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyPasswordField extends StatefulWidget {
  String label;
  double? width;
  TextEditingController textEditingController;

  MyPasswordField({
    super.key,
    required this.label,
    this.width,
    required this.textEditingController,
  });

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 400,
      child: TextField(
        controller: widget.textEditingController,
        obscureText: isShow ? false : true,
        decoration: InputDecoration(
          label: Text(widget.label),
          suffixIcon: InkWell(
            onTap: () => {
              setState(() {
                isShow = !isShow;
              }),
            },
            child: Icon(isShow ? Iconsax.eye_slash : Iconsax.eye),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
