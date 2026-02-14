import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyToast{

  static void showError({String? title, required String message}) {
    Get.snackbar(
      title??"Error",
      message,
      snackPosition: SnackPosition.BOTTOM,   // show at bottom
      backgroundColor: Colors.red,           // red background
      colorText: Colors.white,               // white text
      margin: const EdgeInsets.all(10),      // add spacing
      borderRadius: 8,                       // rounded corners
      duration: const Duration(seconds: 3),  // auto dismiss
      maxWidth: GetPlatform.isDesktop?500:Get.width,
    );
  }

  static void showSuccess({String? title, required String message}) {
    Get.snackbar(
      title??"Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      maxWidth: GetPlatform.isDesktop?500:Get.width,
    );
  }

}