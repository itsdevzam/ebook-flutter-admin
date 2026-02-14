import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class AssestImageByte extends StatelessWidget {
  Uint8List imageBytes;

  AssestImageByte({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10),
      child: Image.memory(
        imageBytes,
        height: 150,
        width: 100,
        fit: BoxFit.fill,
      ),
    );
  }
}
