import 'package:ebook_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ImagePickPlaceHolder extends StatelessWidget {
  const ImagePickPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor.withAlpha(150),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.image),
            SizedBox(height: 10),
            Text("Image"),
          ],
        ),
      ),
    );
  }
}
