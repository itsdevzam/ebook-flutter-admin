import 'package:ebook_admin/features/categories/controller/CategoriesController.dart';
import 'package:ebook_admin/features/categories/model/QuizCatModel.dart';
import 'package:ebook_admin/features/categories/widget/MyQuizAddCatDialog.dart';
import 'package:ebook_admin/helper/MyDeleteDialog.dart';
import 'package:ebook_admin/helper/MyText.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyQuizCatRow extends StatelessWidget {
  int index;
  QuizCatModel quizCatModel;
  CategoriesController categoriesController;

  MyQuizCatRow({
    super.key,
    required this.index,
    required this.categoriesController,
    required this.quizCatModel,
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
                          text: quizCatModel.name!,
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
                      onPressed: ()async {
                        await categoriesController.getQuizSubCat(categoryId: quizCatModel.id.toString());
                        MyQuizAddCatDialog().QuizSubCatList(categoryId: quizCatModel.id.toString(),categoriesController: categoriesController);
                      },
                      icon: Icon(Iconsax.eye, size: 18),
                    ),
                    IconButton(
                      onPressed: () => {
                        categoriesController.quizCatEditTextController.text = quizCatModel.name!,
                        MyQuizAddCatDialog().QuizEditCategory(
                          textEditingController:
                              categoriesController.quizCatEditTextController,
                          callback: () {
                            QuizCatModel editedquizModel = QuizCatModel(
                              id: quizCatModel.id,
                              name: categoriesController
                                  .quizCatEditTextController
                                  .text,
                            );
                            categoriesController.editQuizCat(
                              quizCatModel: editedquizModel,
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
                            Get.back();
                            categoriesController.delQuizCat(
                              id: quizCatModel.id!,
                            );
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
