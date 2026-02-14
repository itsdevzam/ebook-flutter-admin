import 'package:ebook_admin/features/categories/controller/CategoriesController.dart';
import 'package:ebook_admin/features/categories/model/EbookCatModel.dart';
import 'package:ebook_admin/features/ebook/controller/EbookController.dart';
import 'package:ebook_admin/helper/MyDeleteDialog.dart';
import 'package:ebook_admin/helper/MyText.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'MyEbookAddCatDialog.dart';

class MyEbookCatRow extends StatelessWidget {
  int index;
  EbookCatModel ebookCatModel;
  CategoriesController categoriesController;

  MyEbookCatRow({
    super.key,
    required this.index,
    required this.categoriesController,
    required this.ebookCatModel,
  });

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
                      SizedBox(width: 30),
                      MyText(text: "${index + 1}", fontSize: 15),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyText(
                          text: ebookCatModel.name!,
                          fontSize: 15,
                          isOverFlow: true,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => {
                        categoriesController.bookCatEditTextController.text =
                            ebookCatModel.name!,
                        MyEbookAddCatDialog().EbookEditCategory(
                          textEditingController: categoriesController.bookCatEditTextController,
                          callback: () {
                            Get.back();
                            EbookCatModel editedEbookModel = EbookCatModel(
                              id: ebookCatModel.id,
                              name: categoriesController
                                  .bookCatEditTextController
                                  .text,
                            );
                            categoriesController.editBookCat(
                              ebookCatModel: editedEbookModel,
                            );
                            Get.back();
                          },
                        ),
                      },
                      icon: Icon(FontAwesomeIcons.penToSquare, size: 18),
                    ),
                    IconButton(
                      onPressed: () => {
                        MyDeleteDialog(
                          callback: () {
                            categoriesController.delBookCat(
                              id: ebookCatModel.id!,
                            );
                            Get.back();
                          },
                        ),
                      },
                      icon: Icon(FontAwesomeIcons.trash, size: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
