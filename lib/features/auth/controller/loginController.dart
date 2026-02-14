import 'package:ebook_admin/data/repo/login/loginRepo.dart';
import 'package:ebook_admin/features/dashboard/screen/dashboard.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final storage = GetStorage();

  Future<void> loginWithEmailandPass() async {
    if (checkFields()) {
      final response = await LoginRepo().loginNow(
        email: emailController.text,
        password: passController.text,
      );
      if (response != null) {
        MyToast.showSuccess(message: "Login Successfully");
        storage.write("isLoggedIn", true);
        Get.off(() => DashboardPage());
      }
    }
  }

  bool checkFields() {
    if (emailController.text.isEmpty) {
      MyToast.showError(message: "Please enter email");
      return false;
    } else if (!isValidEmail(emailController.text)) {
      MyToast.showError(message: "Please enter a valid email");
      return false;
    } else if (passController.text.isEmpty) {
      MyToast.showError(message: "Please enter password");
      return false;
    }
    return true;
  }

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(email);
  }
}
