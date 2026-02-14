import 'package:ebook_admin/features/categories/controller/CategoriesController.dart';
import 'package:ebook_admin/features/dashboard/screen/dashboard.dart';
import 'package:ebook_admin/features/home/controller/HomeController.dart';
import 'package:ebook_admin/features/setting/controller/SettingsController.dart';
import 'package:ebook_admin/features/user/controller/AllUserController.dart';
import 'package:ebook_admin/utils/colors.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'features/auth/controller/loginController.dart';
import 'features/auth/screen/loginScreen.dart';
import 'features/dashboard/controller/DashboardController.dart';
import 'features/ebook/controller/EbookController.dart';
import 'features/quiz/controller/QuizController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///to save login session and other info
  await GetStorage.init();
  ///all controllers
  Get.put(LoginController());
  Get.lazyPut(() => DashboardController());
  Get.lazyPut(() => QuizController());
  Get.lazyPut(() => EbookController());
  Get.lazyPut(()=>HomeController());
  Get.lazyPut(()=>AllUserController());
  Get.lazyPut(()=>SettingsController());
  Get.lazyPut(()=>CategoriesController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final bool isLoggedIn = storage.read("isLoggedIn") ?? false;
    return GetMaterialApp(
      // initialBinding: bindings(),
      title: Constants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ThemeColors.primaryColor),
      ),
      // home: DashboardPage(),
      home: isLoggedIn?DashboardPage():LoginScreen(),
    );
  }
}


