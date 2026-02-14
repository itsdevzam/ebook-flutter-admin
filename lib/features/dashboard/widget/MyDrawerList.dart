import 'package:ebook_admin/features/auth/controller/loginController.dart';
import 'package:ebook_admin/features/auth/screen/loginScreen.dart';
import 'package:ebook_admin/features/dashboard/controller/DashboardController.dart';
import 'package:ebook_admin/features/home/controller/HomeController.dart';
import 'package:ebook_admin/helper/MyHeading.dart';
import 'package:ebook_admin/helper/MyListTile.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../../helper/MyRectangleButton.dart';

class MyDrawerList extends StatelessWidget {
  MyDrawerList({super.key});

  final _dashboardController = Get.find<DashboardController>();
  final _loginController = Get.find<LoginController>();
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Image.asset("assets/logos/main.png", width: 150, height: 150),
          Center(child: MyHeading(text: Constants.appName, fontSize: 18)),
          SizedBox(height: 30),
          MyListTile(
            label: "Home",
            icon: Iconsax.home,
            callback: () => {
              Get.back(),
              _dashboardController.drawerIndex.value = 0,
              Get.find<HomeController>().fetchHomepage(),
            },
            isSelected: _dashboardController.drawerIndex.value == 0,
          ),
          MyListTile(
            label: "All Users",
            icon: Iconsax.user,
            callback: () => {
              Get.back(),
              _dashboardController.drawerIndex.value = 1,
            },
            isSelected: _dashboardController.drawerIndex.value == 1,
          ),
          // MyListTile(
          //   label: "Pro Users",
          //   icon: Iconsax.crown,
          //   callback: () => {
          //     Get.back(),
          //     _dashboardController.drawerIndex.value = 2,
          //   },
          //   isSelected: _dashboardController.drawerIndex.value == 2,
          // ),
          MyListTile(
            label: "Ebooks",
            icon: Iconsax.book,
            callback: () => {
              _dashboardController.drawerIndex.value = 3,
              Get.back(),
            },
            isSelected: _dashboardController.drawerIndex.value == 3,
          ),
          MyListTile(
            label: "Quiz",
            icon: Iconsax.message_question,
            callback: () => {
              Get.back(),
              _dashboardController.drawerIndex.value = 4,
            },
            isSelected: _dashboardController.drawerIndex.value == 4,
          ),
          MyListTile(
            label: "Categories",
            icon: Iconsax.category,
            callback: () => {
              Get.back(),
              _dashboardController.drawerIndex.value = 5,
            },
            isSelected: _dashboardController.drawerIndex.value == 5,
          ),
          MyListTile(
            label: "Settings",
            icon: Iconsax.setting_2,
            callback: () => {
              Get.back(),
              _dashboardController.drawerIndex.value = 6,
            },
            isSelected: _dashboardController.drawerIndex.value == 6,
          ),
          MyListTile(
            label: "Logout",
            icon: Iconsax.logout,
            callback: () => {
              Get.back(),
              Get.defaultDialog(
                contentPadding: EdgeInsets.only(bottom: 20),
                title: "Alert!",
                middleText: "Are you sure you want to Logout?",
                confirm: MyRectangleButton(
                  label: "Yes",
                  callback: () => {
                    _loginController.emailController.clear(),
                    _loginController.passController.clear(),
                    storage.write("isLoggedIn", false),
                    Get.off(() => LoginScreen()),
                  },
                  width: 100,
                  bgColor: Colors.redAccent,
                  textColor: Colors.white,
                ),
                cancel: MyRectangleButton(
                  label: "No",
                  callback: () => Get.back(),
                  width: 100,
                ),
              ),
            },
            isSelected: _dashboardController.drawerIndex.value == 7,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: TextButton(
              onPressed: () => {},
              child: Text("Made by DevZam © 2026"),
            ),
          ),
        ],
      ),
    );
  }
}
