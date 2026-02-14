import 'package:ebook_admin/features/user/widgets/MyUserRowData.dart';
import 'package:ebook_admin/features/user/widgets/MyUserRowHeading.dart';
import 'package:ebook_admin/helper/MyFooterLayout.dart';
import 'package:ebook_admin/helper/MySearchLayout.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProUserScreen extends StatelessWidget {
  ProUserScreen({super.key});
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Constants.isDesktop(context) ? 40 : 10),

        ///Search
        MySearchLayout(textEditingController: textEditingController,
            heading: "Pro Users",
            searchLabel: "Search By Email",
            searchCallback: () => {},
            iconData: Iconsax.crown),
        SizedBox(height: Constants.isDesktop(context) ? 40 : 20),

        ///Heading
        MyUserRowHeading(),
        Divider(thickness: 2),

        ///Data
        // Expanded(
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     padding: EdgeInsets.only(bottom: 20),
        //     itemBuilder: (context, index) =>
        //         MyUserRowData(index: index),
        //     itemCount: 15,
        //   ),
        // ),

        ///footer
        // MyFooterLayout(),
      ],
    );
  }
}
