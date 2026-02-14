import 'package:ebook_admin/features/home/controller/HomeController.dart';
import 'package:ebook_admin/features/home/widgets/MyCard.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final HomeController _homeController = Get.find();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _homeController.isLoading.value
          ? Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor),)
          : Padding(
              padding: EdgeInsets.only(
                top: Constants.isDesktop(context) ? 50 : 0,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Constants.isDesktop(context)
                      ? 3
                      : (Constants.isTablet(context) ? 2 : 1),
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: 2 / 1,
                ),
                padding: EdgeInsets.all(40),
                itemBuilder: (context, index) {
                  final model = _homeController.homeModel.value;
                  final items = [
                    {"value": model.totalUsers, "label": "Users"},
                    {"value": model.proUsers, "label": "Pro User"},
                    {"value": model.totalEbooks, "label": "Ebooks"},
                    {"value": model.ebooksCat, "label": "Ebook Cat"},
                    {"value": model.totalQuiz, "label": "Quiz"},
                    {"value": model.quizCat, "label": "Quiz Cat"},
                  ];
                  return MyCard(
                    title1: items[index]["value"].toString(),
                    title2: items[index]["label"].toString(),
                  );
                },
                itemCount: 6,
              ),
            ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeController.fetchHomepage();
  }
}


