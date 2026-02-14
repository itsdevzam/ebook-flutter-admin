import 'package:ebook_admin/features/quiz/controller/QuizController.dart';
import 'package:ebook_admin/features/quiz/widget/MyQuizDialog.dart';
import 'package:ebook_admin/features/quiz/widget/MyQuizRowData.dart';
import 'package:ebook_admin/features/quiz/widget/MyQuizRowHeading.dart';
import 'package:ebook_admin/helper/MyFooterLayout.dart';
import 'package:ebook_admin/helper/MySearchLayout.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController _quizController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Constants.isDesktop(context) ? 40 : 10),

        ///Search
        MySearchLayout(
          textEditingController: _quizController.searchQuizController,
          heading: "All Quiz",
          searchLabel: "Search By Question",
          searchCallback: () => {
            _quizController.searchQuiz(
              question: _quizController.searchQuizController.text,
            ),
          },
          iconData: Iconsax.message_question,
        ),
        SizedBox(height: Constants.isDesktop(context) ? 40 : 20),

        ///Heading
        MyQuizRowHeading(),
        Divider(thickness: 2),

        ///Data
        Expanded(
          child: Stack(
            children: [
              Obx(
                () => _quizController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ThemeColors.primaryColor,
                        ),
                      )
                    /// if loading complete then check  we have data or not
                    : (_quizController.quizModelList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 20),
                              itemBuilder: (context, index) => MyQuizRowData(
                                index: index,
                                quizController: _quizController,
                                quizModel: _quizController.quizModelList[index],
                              ),
                              itemCount: _quizController.quizModelList.length,
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.faceFrown,size: 30,),
                                  SizedBox(height: 10,),
                                  Text("No Quiz Available",style: Theme.of(context).textTheme.titleMedium,)],
                              ),
                            )),
              ),
              Positioned(
                bottom: 30,
                right: Constants.isDesktop(context) ? 50 : 20,
                child: FloatingActionButton(
                  heroTag: "QuizScreen",
                  onPressed: () async => {
                    ///empty all controllers so add quiz show empty
                    _quizController.questionController.text = "",
                    _quizController.answerA.text = "",
                    _quizController.answerB.text = "",
                    _quizController.answerC.text = "",
                    _quizController.answerD.text = "",
                    _quizController.explanationController.text = "",

                    ///set option and category to first
                    _quizController.QuizInitOptionValue.value = "A",
                    await _quizController.getQuizCatList(),
                    if (_quizController.quizCatListMap.isNotEmpty)
                      {
                        _quizController.QuizInitCatValue.value =
                            _quizController.quizCatListMap.keys.first,
                      }
                    else
                      {_quizController.QuizInitCatValue.value = -1},

                    ///set quiz Sub Cat list
                    await _quizController.getQuizSubCatList(categoryId: _quizController.quizCatListMap.keys.first.toString()),
                    _quizController.QuizInitSubCatValue.value = _quizController.quizSubCatListMap.keys.first,
                    MyQuizDialog().MyAddQuizDialog(
                      quizController: _quizController,
                    ),
                  },
                  backgroundColor: ThemeColors.primaryColor,
                  child: Icon(Iconsax.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        ///footer
        ///footer
        Obx(
          () => MyFooterLayout(
            current: _quizController.currentPage.value,
            total: _quizController.totalPage.value,
            leftcallback: () {
              final page = int.parse(_quizController.currentPage.value);
              if (page <= 1) {
                MyToast.showError(message: "No more pages available");
                return;
              }
              _quizController.getQuiz(page: (page - 1).toString());
            },
            rightcallback: () {
              final page = int.parse(_quizController.currentPage.value);
              final total = int.parse(_quizController.totalPage.value);
              if (page >= total) {
                MyToast.showError(message: "No more pages available");
                return;
              }
              _quizController.getQuiz(page: (page + 1).toString());
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quizController.getQuiz(page: "1");
  }
}
