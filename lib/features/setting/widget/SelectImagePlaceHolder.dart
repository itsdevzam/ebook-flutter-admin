import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SelectImagePlaceHolder extends StatelessWidget {
  VoidCallback callback;
  SelectImagePlaceHolder({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
      BorderRadiusGeometry.circular(20),
      child: Container(
        height: 200,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              onPressed: callback,
              icon: Icon(Iconsax.add, size: 22),
            ),
          ),
        ),
      ),
    );
  }
}
