import 'package:ebook_admin/features/quiz/controller/QuizController.dart';
import 'package:ebook_admin/features/quiz/model/QuizModel.dart';
import 'package:ebook_admin/helper/MyDeleteDialog.dart';
import 'package:ebook_admin/helper/MyText.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'MyQuizDialog.dart';

class MyQuizRowData extends StatelessWidget {
  int index;
  QuizController quizController;
  QuizModel quizModel;

  MyQuizRowData({
    super.key,
    required this.quizModel,
    required this.index,
    required this.quizController,
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
                      SizedBox(width: 10),
                      MyText(text: "${index + 1}", fontSize: 15),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyText(
                          text: quizModel.question!,
                          fontSize: 15,
                          isOverFlow: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Constants.isDesktop(context) ? 200 : 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: MyText(
                          text: "${quizController.quizCatListMap[quizModel.categoryId]} - ${quizController.quizSubCatListMap[quizModel.subcategory_id]}",
                          fontSize: 15,
                          isOverFlow: true,
                        ),

                        ///convert id to category
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: IconButton(
                        onPressed: ()async => {
                          ///Add text to controllers before click edit
                          quizController.questionController.text = quizModel.question!,
                          quizController.answerA.text = quizModel.optionA!,
                          quizController.answerB.text = quizModel.optionB!,
                          quizController.answerC.text = quizModel.optionC!,
                          quizController.answerD.text = quizModel.optionD!,
                          quizController.explanationController.text = quizModel.explanation!,

                          ///to select correct value in drop down
                          quizController.QuizInitOptionValue.value = quizModel.correctAns!,

                          ///for category select
                          quizController.QuizInitCatValue.value = quizModel.categoryId!,
                          ///for sub cat select
                          quizController.QuizInitSubCatValue.value = quizModel.subcategory_id!,

                          ///for categories
                          await quizController.getQuizCatList(),
                          ///for sub categories
                          await quizController.getQuizSubCatList(categoryId: quizModel.categoryId.toString()),


                          MyQuizDialog().MyEditQuizDialog(
                            quizController: quizController,
                            quizModel: quizModel,
                          ),
                        },
                        icon: Icon(FontAwesomeIcons.penToSquare, size: 18),
                      ),
                    ),
                    IconButton(
                      onPressed: () => {
                        MyDeleteDialog(
                          callback: () => {
                            quizController.deleteQuiz(id: quizModel.id!),
                            Get.back(),
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
