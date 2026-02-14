
import 'package:ebook_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyLoadingDialog{
  MyLoadingDialog() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.only(bottom: 20),
      title: "Processing",
      content: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: CircularProgressIndicator(color: ThemeColors.primaryColor,),
      ),
    );
  }
}