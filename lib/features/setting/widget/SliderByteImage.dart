import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SliderByteImage extends StatelessWidget {
  Uint8List imageBytes;
  VoidCallback onCutCallback;
  SliderByteImage({super.key,required this.onCutCallback,required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(10),
          child: Image.memory(
            imageBytes,
            height: 200,
            width: 400,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: CircleAvatar(
            radius: 15,
            child: IconButton(
              onPressed: onCutCallback,
              icon: Icon(
                FontAwesomeIcons.xmark,
                size: 16,
                color: Colors.red,
              ),
            ),
          ),
        )
      ],
    );
  }
}
