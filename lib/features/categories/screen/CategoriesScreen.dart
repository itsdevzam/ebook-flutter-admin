import 'package:ebook_admin/features/categories/controller/CategoriesController.dart';
import 'package:ebook_admin/features/categories/widget/MyEbookCatRow.dart';
import 'package:ebook_admin/features/categories/widget/MyEbookCategoryHeading.dart';
import 'package:ebook_admin/features/categories/widget/MyQuizAddCatDialog.dart';
import 'package:ebook_admin/features/categories/widget/MyQuizCatRow.dart';
import 'package:ebook_admin/features/categories/widget/MyQuizCategoryHeading.dart';
import 'package:ebook_admin/features/quiz/controller/QuizController.dart';
import 'package:ebook_admin/helper/MyHeading.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../widget/MyEbookAddCatDialog.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesController _categoriesController = Get.find();
  final _quizControler = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Constants.isDesktop(context) ? 40 : 10),

        ///Heading
        MyHeading(text: "All Categories"),
        SizedBox(height: Constants.isDesktop(context) ? 40 : 20),

        ///Tabs
        DefaultTabController(
          length: 2,
          child: Expanded(
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(icon: Icon(Iconsax.book), text: "Ebook"),
                    Tab(icon: Icon(Iconsax.message_question), text: "Quiz"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 20),
                          MyEbookCategoryHeading(),

                          ///Data
                          Expanded(
                            child: Stack(
                              children: [
                                Obx(
                                  () => _categoriesController.isLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: ThemeColors.primaryColor,
                                          ),
                                        )
                                      ///if data is available or not
                                      : (_categoriesController
                                                .ebookModeList
                                                .isNotEmpty
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                padding: EdgeInsets.only(
                                                  bottom: 20,
                                                ),
                                                itemBuilder: (context, index) =>
                                                    MyEbookCatRow(
                                                      index: index,
                                                      ebookCatModel:
                                                          _categoriesController
                                                              .ebookModeList[index],
                                                      categoriesController:
                                                          _categoriesController,
                                                    ),
                                                itemCount: _categoriesController
                                                    .ebookModeList
                                                    .length,
                                              )
                                            : Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .faceFrown,
                                                      size: 30,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "No Ebook Available",
                                                      style: Theme.of(
                                                        context,
                                                      ).textTheme.titleMedium,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                ),
                                Positioned(
                                  bottom: 30,
                                  right: Constants.isDesktop(context) ? 50 : 20,
                                  child: FloatingActionButton(
                                    onPressed: () => {
                                      MyEbookAddCatDialog().EbookAddCategory(
                                        textEditingController:
                                            _categoriesController
                                                .bookCatTextController,
                                        callback: () {
                                          Get.back();
                                          _categoriesController.addBookCat(
                                            name: _categoriesController
                                                .bookCatTextController
                                                .text,
                                          );
                                        },
                                      ),
                                    },
                                    backgroundColor: ThemeColors.primaryColor,
                                    child: Icon(
                                      Iconsax.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 30),
                          MyQuizCategoryHeading(),

                          ///Data
                          Expanded(
                            child: Stack(
                              children: [
                                Obx(
                                  () => _categoriesController.isLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: ThemeColors.primaryColor,
                                          ),
                                        )
                                  ///if data is available or not
                                      : (_categoriesController.quizModeList.isNotEmpty?ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(bottom: 20),
                                          itemBuilder: (context, index) =>
                                              MyQuizCatRow(
                                                index: index,
                                                categoriesController:
                                                    _categoriesController,
                                                quizCatModel:
                                                    _categoriesController
                                                        .quizModeList[index],
                                              ),
                                          itemCount: _categoriesController
                                              .quizModeList
                                              .length,
                                        ):Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesomeIcons.faceFrown, size: 30),
                                        SizedBox(height: 10),
                                        Text(
                                          "No Ebook Available",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                                Positioned(
                                  bottom: 30,
                                  right: Constants.isDesktop(context) ? 50 : 20,
                                  child: FloatingActionButton(
                                    heroTag: "CatScreen",
                                    onPressed: () => {
                                      MyQuizAddCatDialog().SelectCategoryDialog(
                                        categoriesController: _categoriesController,
                                        quizController: _quizControler
                                      )
                                    },
                                    backgroundColor: ThemeColors.primaryColor,
                                    child: Icon(
                                      Iconsax.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoriesController.getBookCat();
    _categoriesController.getQuizCat();
  }
}
