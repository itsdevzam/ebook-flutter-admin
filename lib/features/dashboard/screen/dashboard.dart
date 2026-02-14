import 'package:ebook_admin/features/auth/controller/loginController.dart';
import 'package:ebook_admin/features/categories/screen/CategoriesScreen.dart';
import 'package:ebook_admin/features/dashboard/controller/DashboardController.dart';
import 'package:ebook_admin/features/ebook/controller/EbookController.dart';
import 'package:ebook_admin/features/ebook/screen/EbookScreen.dart';
import 'package:ebook_admin/features/home/screen/HomePage.dart';
import 'package:ebook_admin/features/dashboard/widget/MyDrawerList.dart';
import 'package:ebook_admin/features/quiz/controller/QuizController.dart';
import 'package:ebook_admin/features/quiz/screen/QuizScreen.dart';
import 'package:ebook_admin/features/setting/screen/SettingScreen.dart';
import 'package:ebook_admin/features/user/screen/AllUsersScreen.dart';
import 'package:ebook_admin/features/user/screen/ProUserScreen.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DashboardController _dashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(width: 250, child: MyDrawerList()),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Drawer For Web
          Constants.isDesktop(context)
              ? Expanded(flex: 2, child: MyDrawerList())
              : SizedBox(),
          Constants.isDesktop(context)
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: VerticalDivider(color: Colors.blue, thickness: 1),
                )
              : SizedBox(),

          ///Body for web and app
          Expanded(
            flex: 8,
            child: Column(
              children: [
                ///App Bar for mobile
                Constants.isDesktop(context)
                    ? SizedBox()
                    : Container(
                        width: double.maxFinite,
                        color: Colors.blue,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        child: InkWell(
                          onTap: () => {
                            _scaffoldKey.currentState?.openDrawer(),
                          },
                          child: Icon(Iconsax.menu, color: Colors.white),
                        ),
                      ),

                ///HomePage for web and app
                Expanded(
                  child: Obx(
                    () => IndexedStack(
                      index: _dashboardController.drawerIndex.value,
                      children: <Widget>[
                        HomePage(),
                        AllUsersScreen(),
                        ProUserScreen(),
                        EbookScreen(),
                        QuizScreen(),
                        CategoriesScreen(),
                        SettingScreen(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
