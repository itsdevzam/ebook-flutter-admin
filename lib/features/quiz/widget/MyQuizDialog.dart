import 'dart:async';

import 'package:ebook_admin/features/quiz/controller/QuizController.dart';
import 'package:ebook_admin/features/quiz/model/QuizModel.dart';
import 'package:ebook_admin/helper/MyRectangleButton.dart';
import 'package:ebook_admin/helper/MyTextField.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyQuizDialog {
  void MyAddQuizDialog({required QuizController quizController}) async {
    await Get.defaultDialog(
      title: "Add Quiz",
      content: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: MyTextField(
                label: "Question",
                maxlines: 2,
                textEditingController: quizController.questionController,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Option A",
                    textEditingController: quizController.answerA,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Option B",
                    textEditingController: quizController.answerB,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Option C",
                    textEditingController: quizController.answerC,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Option D",
                    textEditingController: quizController.answerD,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Explanation",
                    textEditingController: quizController.explanationController,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(10),
                    decoration: InputDecoration(
                      label: Text("Select Correct Option"),
                      border: OutlineInputBorder(),
                    ),
                    initialValue: quizController.QuizInitOptionValue.value,
                    items: [
                      DropdownMenuItem(value: "A", child: Text("Option A")),
                      DropdownMenuItem(value: "B", child: Text("Option B")),
                      DropdownMenuItem(value: "C", child: Text("Option C")),
                      DropdownMenuItem(value: "D", child: Text("Option D")),
                    ],
                    onChanged: (value) {
                      quizController.QuizInitOptionValue.value = value!;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                    () => quizController.quizCatListMap.isEmpty
                        ? Text("No Categories")
                        : DropdownButtonFormField(
                            borderRadius: BorderRadius.circular(10),
                            decoration: InputDecoration(
                              label: Text("Select Category"),
                              border: OutlineInputBorder(),
                            ),
                            initialValue: quizController.QuizInitCatValue.value,
                            items: quizController.quizCatListMap.entries.map((
                              e,
                            ) {
                              return DropdownMenuItem(
                                value: e.key,
                                child: Text(e.value),
                              );
                            }).toList(),
                            onChanged: (value)async {
                              ///update sub cat list
                              quizController.QuizInitCatValue.value = value!;
                              await quizController.getQuizSubCatList(categoryId: value.toString());
                              quizController.QuizInitSubCatValue.value = quizController.quizSubCatListMap.keys.first;
                            },
                          ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                        () => quizController.quizSubCatListMap.isEmpty
                        ? Text("No Sub Categories")
                        : DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                        label: Text("Select SubCategory"),
                        border: OutlineInputBorder(),
                      ),
                      initialValue: quizController.QuizInitSubCatValue.value,
                      items: quizController.quizSubCatListMap.entries.map((
                          e,
                          ) {
                        return DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        quizController.QuizInitSubCatValue.value = value!;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            MyRectangleButton(
              label: "Save",
              callback: () => {
                if (quizController.QuizInitCatValue.value == -1 || quizController.quizSubCatListMap.isEmpty)
                  {
                    Get.back(),
                    Timer(
                      Duration(milliseconds: 100),
                      () => MyToast.showError(
                        message: "Please add category first",
                      ),
                    ),
                  }
                else if (quizController.checkFields())
                  {
                    {
                      quizController.addQuiz(
                        quizModel: QuizModel(
                          question: quizController.questionController.text,
                          optionA: quizController.answerA.text,
                          optionB: quizController.answerB.text,
                          optionC: quizController.answerC.text,
                          optionD: quizController.answerD.text,
                          correctAns: quizController.QuizInitOptionValue.value,
                          categoryId: quizController.QuizInitCatValue.value,
                          subcategory_id: quizController.QuizInitSubCatValue.value,
                          explanation: quizController.explanationController.text
                        ),
                      ),
                    },
                  }
                else
                  {
                    Get.back(),
                    Timer(
                      Duration(milliseconds: 100),
                      () =>
                          MyToast.showError(message: "Please fill all fields"),
                    ),
                  },
                Get.back(),
              },
            ),
          ],
        ),
      ),
    );
  }

  void MyEditQuizDialog({
    required QuizController quizController,
    required QuizModel quizModel,
  }) async {
    await Get.defaultDialog(
      title: "Edit Quiz",
      content: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: MyTextField(
                label: "Question",
                maxlines: 2,
                textEditingController: quizController.questionController,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Option A",
                    textEditingController: quizController.answerA,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Option B",
                    textEditingController: quizController.answerB,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Option C",
                    textEditingController: quizController.answerC,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Option D",
                    textEditingController: quizController.answerD,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Explanation",
                    textEditingController: quizController.explanationController,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(10),
                    decoration: InputDecoration(
                      label: Text("Select Correct Option"),
                      border: OutlineInputBorder(),
                    ),
                    initialValue: quizController.QuizInitOptionValue.value,
                    items: [
                      DropdownMenuItem(value: "A", child: Text("Option A")),
                      DropdownMenuItem(value: "B", child: Text("Option B")),
                      DropdownMenuItem(value: "C", child: Text("Option C")),
                      DropdownMenuItem(value: "D", child: Text("Option D")),
                    ],
                    onChanged: (value) {
                      quizController.QuizInitOptionValue.value = value!;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
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
                            items: quizController.quizCatListMap.entries.map((
                              entry,
                            ) {
                              return DropdownMenuItem<int>(
                                value: entry.key, // category id
                                child: Text(entry.value), // category name
                              );
                            }).toList(),
                            onChanged: (value) async {
                              quizController.QuizInitCatValue.value = value!;
                              await quizController.getQuizSubCatList(categoryId: value.toString());
                              quizController.QuizInitSubCatValue.value = quizController.quizSubCatListMap.keys.first;
                            },
                          ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                        () => quizController.quizSubCatListMap.isEmpty
                        ? Text("No Sub Categories")
                        : DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                        label: Text("Select SubCategory"),
                        border: OutlineInputBorder(),
                      ),
                      initialValue: quizController.QuizInitSubCatValue.value,
                      items: quizController.quizSubCatListMap.entries.map((
                          e,
                          ) {
                        return DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        quizController.QuizInitSubCatValue.value = value!;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            MyRectangleButton(
              label: "Update",
              callback: () => {
                if (quizController.checkFields())
                  {
                    quizController.editQuiz(
                      quizModel: QuizModel(
                        id: quizModel.id!,
                        question: quizController.questionController.text,
                        optionA: quizController.answerA.text,
                        optionB: quizController.answerB.text,
                        optionC: quizController.answerC.text,
                        optionD: quizController.answerD.text,
                        correctAns: quizController.QuizInitOptionValue.value,
                        categoryId: quizController.QuizInitCatValue.value,
                        subcategory_id: quizController.QuizInitSubCatValue.value,
                        explanation: quizController.explanationController.text
                      ),
                    ),
                    Get.back(),
                  }
                else
                  {
                    Timer(
                      Duration(milliseconds: 100),
                      () =>
                          MyToast.showError(message: "Please fill all fields"),
                    ),
                    Get.back(),
                  },
              },
            ),
          ],
        ),
      ),
    );
  }
}
