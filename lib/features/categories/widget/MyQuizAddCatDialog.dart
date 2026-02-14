import 'package:ebook_admin/features/categories/controller/CategoriesController.dart';
import 'package:ebook_admin/features/quiz/controller/QuizController.dart';
import 'package:ebook_admin/helper/MyDeleteDialog.dart';
import 'package:ebook_admin/helper/MyRectangleButton.dart';
import 'package:ebook_admin/helper/MyText.dart';
import 'package:ebook_admin/helper/MyTextField.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/colors.dart' show ThemeColors;

class MyQuizAddCatDialog {
  void QuizAddCategory({
    required CategoriesController categoriesController,
  }) async {
    await Get.defaultDialog(
      title: "Add Quiz Category",
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: MyTextField(
              label: "Name",
              textEditingController: categoriesController.quizCatTextController,
            ),
          ),
          SizedBox(height: 20),
          MyRectangleButton(
            label: "Save",
            callback: () {
              Get.back();
              categoriesController.addQuizCat(
                name: categoriesController.quizCatTextController.text,
              );
            },
          ),
        ],
      ),
    );
  }

  void QuizAddSubCategory({
    required CategoriesController categoriesController,
    required QuizController quizController,
  }) async {
    await Get.defaultDialog(
      title: "Add Quiz SubCategory",
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            MyTextField(
              label: "Name",
              textEditingController:
                  categoriesController.quizSubCatTextController,
            ),
            SizedBox(height: 20),

            ///dropdown
            Obx(
              () => quizController.isLoadingForCategories.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ThemeColors.primaryColor,
                      ),
                    )
                  : DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                        label: Text("Select Category"),
                        border: OutlineInputBorder(),
                      ),
                      initialValue: quizController.QuizInitCatValue.value,
                      items: quizController.quizCatListMap.entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.key, // category id
                          child: Text(entry.value), // category name
                        );
                      }).toList(),
                      onChanged: (value) {
                        quizController.QuizInitCatValue.value = value!;
                      },
                    ),
            ),
            SizedBox(height: 20),
            MyRectangleButton(
              label: "Save",
              callback: () {
                Get.back();
                if (quizController.QuizInitCatValue.value == -1) {
                  MyToast.showError(message: "Please add category");
                } else {
                  categoriesController.addQuizSubCat(
                    name: categoriesController.quizSubCatTextController.text,
                    categoryId: quizController.QuizInitCatValue.value
                        .toString(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void SelectCategoryDialog({
    required CategoriesController categoriesController,
    required QuizController quizController,
  }) async {
    await Get.defaultDialog(
      title: "You want add",
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            MyRectangleButton(
              label: "Quiz Category",
              callback: () {
                Get.back();
                QuizAddCategory(categoriesController: categoriesController);
              },
              width: 300,
            ),
            SizedBox(height: 20),
            MyText(text: "OR"),
            SizedBox(height: 20),
            MyRectangleButton(
              label: "Quiz Subcategory",
              callback: () async {
                await quizController.getQuizCatList();

                ///set category to first
                if (quizController.quizCatListMap.isNotEmpty) {
                  quizController.QuizInitCatValue.value =
                      quizController.quizCatListMap.keys.first;
                } else {
                  quizController.QuizInitCatValue.value = -1;
                }

                ///clear subcat name
                categoriesController.quizSubCatTextController.text = "";
                Get.back();
                QuizAddSubCategory(
                  quizController: quizController,
                  categoriesController: categoriesController,
                );
              },
              width: 300,
            ),
          ],
        ),
      ),
    );
  }

  void QuizEditCategory({
    required TextEditingController textEditingController,
    required VoidCallback callback,
  }) async {
    await Get.defaultDialog(
      title: "Edit Quiz Category",
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: MyTextField(
              label: "Name",
              textEditingController: textEditingController,
            ),
          ),
          SizedBox(height: 20),
          MyRectangleButton(label: "Update", callback: callback),
        ],
      ),
    );
  }

  void QuizSubCatList({required String categoryId,required CategoriesController categoriesController}) async {
    await Get.defaultDialog(
      title: "Quiz Subcategories",
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 300,
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${index+1}. ${categoriesController.quizSubCatModeList[index].name}", style: TextStyle(fontSize: 18),),
                      IconButton(onPressed: (){
                        Get.back();
                        MyDeleteDialog(
                          callback: () {
                            categoriesController.delQuizSubCat(id: categoriesController.quizSubCatModeList[index].id!);
                            Get.back();
                          },
                        );
                      }, icon: Icon(FontAwesomeIcons.trash, size: 18))
                    ],
                  ),
                ),
                itemCount: categoriesController.quizSubCatModeList.length,
              ),
            ),
          ),
          SizedBox(height: 20),
          MyRectangleButton(label: "Close", callback: () {
            Get.back();
          }),
        ],
      ),
    );
  }
}
