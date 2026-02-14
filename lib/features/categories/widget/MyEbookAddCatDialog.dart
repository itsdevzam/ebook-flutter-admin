import 'package:ebook_admin/helper/MyRectangleButton.dart';
import 'package:ebook_admin/helper/MyTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEbookAddCatDialog {

  void EbookAddCategory({required TextEditingController textEditingController,required VoidCallback callback}) async {
    await Get.defaultDialog(
      title: "Add Ebook Category",
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: MyTextField(
              label: "Name",
              textEditingController: textEditingController,
            ),
          ),
          SizedBox(height: 20),
          MyRectangleButton(label: "Save", callback: callback),
        ],
      ),
    );
  }

  void EbookEditCategory({required TextEditingController textEditingController,required VoidCallback callback})async{
    await Get.defaultDialog(
      title: "Edit Ebook Category",
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: MyTextField(
              label: "Name",
              textEditingController: textEditingController,
            ),
          ),
          SizedBox(height: 20),
          MyRectangleButton(label: "Update", callback:callback),
        ],
      ),
    );
  }
}
