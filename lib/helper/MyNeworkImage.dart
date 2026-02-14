import 'package:ebook_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class MyNetworkImage extends StatelessWidget {
  String image;
  MyNetworkImage({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: "assets/logos/ebook.jpg",
        image: image,
        width: 80,
        height: 120,
        fit: BoxFit.fill,
        placeholderErrorBuilder: (context, error, stackTrace) {
          return Shimmer.fromColors(
            baseColor: ThemeColors.primaryColor,
            highlightColor: Colors.grey,
            child: Container(
              height: 120,
              width: 80,
              color: Colors.white,
            ),
          );
        },
        imageErrorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80,
            height: 120,
            alignment: Alignment.center,
            color: ThemeColors.primaryColor,
            child: Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.triangleExclamation,color: Colors.white,),
                Text("Error",style: TextStyle(color: Colors.white),)
              ],
            ),
          );
        },
      ),
    );
  }
}
