import 'dart:async';
import 'dart:typed_data';

import 'package:ebook_admin/features/ebook/controller/EbookController.dart';
import 'package:ebook_admin/features/ebook/model/EbookModel.dart';
import 'package:ebook_admin/features/ebook/widget/MyEbookDialog.dart';
import 'package:ebook_admin/helper/MyDeleteDialog.dart';
import 'package:ebook_admin/helper/MyNeworkImage.dart';
import 'package:ebook_admin/helper/MyText.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class MyEbookRowData extends StatelessWidget {
  int index;
  EbookController ebookController;
  EbookModel ebookModel;

  MyEbookRowData({
    super.key,
    required this.ebookModel,
    required this.index,
    required this.ebookController,
  });

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 2,
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      MyText(text: "${(index + 1) + (int.parse(ebookController.currentPage.value) - 1) * 10}", fontSize: 15),
                      SizedBox(width: 10),
                      // ClipRRect(borderRadius: BorderRadiusGeometry.circular(10),child: Image.network(ebookModel.image??"assets/logos/ebook.jpg",width: 80,height: 120,fit: BoxFit.fill,)),
                      MyNetworkImage(
                        image: "${Constants.baseURL}${ebookModel.image!}",
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: ebookModel.title!,
                              fontSize: 15,
                              isOverFlow: true,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 5),
                            MyText(
                              text: ebookModel.description!,
                              fontSize: 15,
                              isOverFlow: true,
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: MyText(
                          text:
                              ebookController.ebookCatListMap[ebookModel
                                  .categoryId] ??
                              "Unknown",
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: IconButton(
                          onPressed: () async {
                            await ebookController.getBookCatList();
                            ebookController.titleTextController.text = ebookModel.title!;
                            ebookController.descTextController.text = ebookModel.description!;
                            ebookController.urlTextController.text = ebookModel.url!;
                            ebookController.ebookInitOptionValue.value = ebookModel.isPaid!;
                            ebookController.ebookCatOptionValue.value = ebookModel.categoryId!;
                            ebookController.imageBytes = await ebookController.urlToBytes("${Constants.baseURL}${ebookModel.image}");
                            ebookController.isImagePicked.value = true;
                            MyEbookDialog().MyEditEbookDialog(
                              ebookController: ebookController,
                              ebookModel: ebookModel
                            );
                          },
                          icon: Icon(FontAwesomeIcons.penToSquare, size: 18),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          MyDeleteDialog(
                            callback: () {
                              ebookController.deleteBook(
                                id: ebookModel.id.toString(),
                              );
                              Timer(Duration(milliseconds: 500),()=>ebookController.allEbooksData(page: ebookController.currentPage.toString()));
                              Get.back();
                            },
                          );
                        },
                        icon: Icon(FontAwesomeIcons.trash, size: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
