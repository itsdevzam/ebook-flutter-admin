import 'package:ebook_admin/helper/MyRectangleButton.dart';
import 'package:ebook_admin/helper/MyTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyUserDialog {
  void MyViewUserDialog({
    required nameTEC,
    required emailTEC,
    required proUserTEC,
    required expiryTEC,
  }) async {
    await Get.defaultDialog(
      title: "User Details",
      content: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Name",
                    textEditingController: nameTEC,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Email",
                    textEditingController: emailTEC,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Pro User",
                    textEditingController: proUserTEC,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyTextField(
                    label: "Expiry Date",
                    textEditingController: expiryTEC,
                  ),
                ),
                SizedBox(height: 20),
                MyRectangleButton(label: "Close", callback: () => Get.back()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
