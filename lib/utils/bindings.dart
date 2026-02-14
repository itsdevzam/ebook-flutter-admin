
import 'package:get/get.dart';
import '../features/auth/controller/loginController.dart';

class bindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}