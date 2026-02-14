import 'package:ebook_admin/helper/MyNeworkImage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FontAwesomeIcons;

class MyNetworkDelImage extends StatelessWidget {
  String image;
  MyNetworkDelImage({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(10),
          child: MyNetworkImage(image: image),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: CircleAvatar(
            radius: 15,
            child: IconButton(
              onPressed: () => {},
              icon: Icon(
                FontAwesomeIcons.xmark,
                size: 16,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
