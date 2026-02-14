import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'MyRectangleButton.dart';

class MyDeleteDialog {
  VoidCallback? callback;
  MyDeleteDialog({this.callback}) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.only(bottom: 20),
      title: "Alert!",
      middleText: "Are you sure you want to delete?",
      confirm: MyRectangleButton(
        label: "Yes",
        callback: callback??() => {},
        width: 100,
        bgColor: Colors.redAccent,
        textColor: Colors.white,
      ),
      cancel: MyRectangleButton(
        label: "No",
        callback: () => Get.back(),
        width: 100,
      ),
    );
  }
}
