import 'package:ebook_admin/data/repo/users/AllUsersRepo.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/UserModel.dart';


class AllUserController extends GetxController {
  RxString currentPage = "".obs;
  RxString totalPage = "".obs;
  Rx<List<UserModel>> userModelList = RxList([UserModel()]).obs;
  RxBool isLoading = false.obs;

  TextEditingController nameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController proUserTEC = TextEditingController();
  TextEditingController expiryTEC = TextEditingController();
  TextEditingController seacrhController = TextEditingController();

  Future<void> allUsersData({required String page}) async {
    isLoading.value = true;
    final response = await AllUsersRepo().fetchAllUser(page: page);
    if (response != null) {
      try {
        currentPage.value = response["page"].toString();
        totalPage.value = response["totalPages"].toString();
        List<dynamic> userList = response["data"];
        userModelList.value = RxList(userList.map((e)=> UserModel.fromJson(e)).toList());
        isLoading.value = false;
      } catch (e) {
        MyToast.showError(message: e.toString());
        isLoading.value = false;
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> deleteUser({required String uid})async{
    isLoading.value = true;
    final response = await AllUsersRepo().deleteUser(uid: uid);
    if(response){
      // Remove user from the list
      userModelList.value.removeWhere((user) => user.uid == uid);
      MyToast.showSuccess(message: "User Deleted Successfully");
    }
    isLoading.value = false;
  }

  Future<void> searchUser({required String email})async{
    isLoading.value = true;
    final response = await AllUsersRepo().searchUser(email: email);
    if(response!=null){
      userModelList.value = RxList(response.map((e)=>UserModel.fromJson(e)).toList());
    }
    isLoading.value = false;
  }
}
