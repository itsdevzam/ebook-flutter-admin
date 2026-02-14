import 'package:ebook_admin/features/auth/controller/loginController.dart';
import 'package:ebook_admin/helper/MyHeading.dart';
import 'package:ebook_admin/helper/MyOutlineBtn.dart';
import 'package:ebook_admin/helper/MyPasswordField.dart';
import 'package:ebook_admin/helper/MyTextField.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController _loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logos/main.png",
                  width: Constants.isMobile(context) ? 100 : 150,
                  height: Constants.isMobile(context) ? 100 : 150,
                ),
                MyHeading(
                  text: "Login Here",
                  fontSize: Constants.isMobile(context) ? 25 : 30,
                ),
              ],
            ),
            MyTextField(
              label: "Email",
              width: Constants.isMobile(context)
                  ? (Constants.getScreenWidth(context) - 50)
                  : 400,
              textEditingController: _loginController.emailController,
            ),
            SizedBox(height: 20),
            MyPasswordField(
              label: "Password",
              width: Constants.isMobile(context)
                  ? (Constants.getScreenWidth(context) - 50)
                  : 400,
              textEditingController: _loginController.passController,
            ),
            SizedBox(height: 30),
            MyOutlineBtn(label: "Login", height: Constants.isMobile(context)?50:40, callback: () => {
              _loginController.loginWithEmailandPass(),
            }),
          ],
        ),
      ),
    );
  }
}
