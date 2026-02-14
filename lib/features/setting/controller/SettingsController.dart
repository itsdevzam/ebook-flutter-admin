import 'dart:typed_data';

import 'package:ebook_admin/data/repo/settings/AdminProfileRepo.dart';
import 'package:ebook_admin/data/repo/settings/ResetPassRepo.dart';
import 'package:ebook_admin/data/repo/settings/SettingsRepo.dart';
import 'package:ebook_admin/features/setting/model/AdminProfileModel.dart';
import 'package:ebook_admin/features/setting/model/SettingsModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:ebook_admin/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SettingsController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<SettingsModel> settingsModel = SettingsModel().obs;
  Rx<AdminProfileModel> adminProfileModel = AdminProfileModel().obs;
  RxBool isImgSelected = false.obs;
  Rx<Uint8List> sliderOne = Uint8List(0).obs;
  Rx<Uint8List> sliderTwo = Uint8List(0).obs;
  Rx<Uint8List> sliderThree = Uint8List(0).obs;

  //settings
  TextEditingController appNameController = TextEditingController();
  TextEditingController admobBannerController = TextEditingController();
  TextEditingController admobInterController = TextEditingController();
  TextEditingController admobVideoController = TextEditingController();
  TextEditingController copyrightController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController oneMonthController = TextEditingController();
  TextEditingController sixMonthController = TextEditingController();
  TextEditingController oneYearController = TextEditingController();
  //admin profile
  TextEditingController adminTitleController = TextEditingController();
  TextEditingController adminUsernameController = TextEditingController();
  TextEditingController adminEmailController = TextEditingController();
  //reset pass
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  Future<void> getSettings() async {
    isLoading.value = true;
    final res = await SettingsRepo().fetchSettings();
    if (res != null) {
      settingsModel.value = SettingsModel.fromJson(res);
      appNameController.text = settingsModel.value.appName!;
      admobBannerController.text = settingsModel.value.admobBannerId!;
      admobInterController.text = settingsModel.value.admobInterstitialId!;
      admobVideoController.text = settingsModel.value.admobVideoId!;
      copyrightController.text = settingsModel.value.copyrightText!;
      couponController.text = settingsModel.value.coupon!;
      discountController.text = settingsModel.value.discountPercentage!;
      oneMonthController.text = settingsModel.value.oneMonth!;
      sixMonthController.text = settingsModel.value.sixMonth!;
      oneYearController.text = settingsModel.value.oneYear!;
      sliderOne.value = await urlToBytes("${Constants.baseURL}${settingsModel.value.sliderOne!}");
      sliderTwo.value = await urlToBytes("${Constants.baseURL}${settingsModel.value.sliderTwo!}");
      sliderThree.value = await urlToBytes("${Constants.baseURL}${settingsModel.value.slideThree!}");
      isLoading.value = false;
    }
  }

  Future<void> updateSettings({
    required appName,
    required banner,
    required inter,
    required video,
    required copyright,
    required coupon,
    required discount,
    required oneMonth,
    required sixMonth,
    required oneYear,
  }) async {
    isLoading.value = true;
    if (checkFields()) {
      final res = await SettingsRepo().setUpdateSettings(
        settingsModel: SettingsModel(
          id: 1,
          appName: appName,
          admobBannerId: banner,
          admobInterstitialId: inter,
          admobVideoId: video,
          copyrightText: copyright,
          coupon: coupon,
          discountPercentage: discount,
          oneMonth: oneMonth,
          sixMonth: sixMonth,
          oneYear: oneYear,
        ),
      );
      if (res) {
        MyToast.showSuccess(message: "Update Successfully");
      } else {
        MyToast.showError(message: "Someting Went Wrong");
      }
    }else{
      MyToast.showError(message: "Please Enter All Values");
    }
    isLoading.value = false;
  }

  bool checkFields() {
    if (appNameController.text.isEmpty) {
      return false;
    } else if (admobBannerController.text.isEmpty) {
      return false;
    } else if (admobInterController.text.isEmpty) {
      return false;
    } else if (admobVideoController.text.isEmpty) {
      return false;
    } else if (copyrightController.text.isEmpty) {
      return false;
    }else if (adminTitleController.text.isEmpty) {
      return false;
    }else if (adminEmailController.text.isEmpty) {
      return false;
    }else if (adminUsernameController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> getAdminProfile() async {
    isLoading.value = true;
    final res = await AdminProfileRepo().fetchAdminProfile();
    if (res != null) {
      adminProfileModel.value = AdminProfileModel.fromJson(res);
      adminTitleController.text = adminProfileModel.value.adminTitle!;
      adminUsernameController.text = adminProfileModel.value.adminUsername!;
      adminEmailController.text = adminProfileModel.value.adminEmail!;
      isLoading.value = false;
    }
  }

  Future<void> updateAdminProfile({
    required adminTitle,
    required adminUsername,
    required adminEmail,
  }) async {
    isLoading.value = true;
    if (checkFields()) {
      final res = await AdminProfileRepo().setUpdateAdminProfile(adminProfileModel: AdminProfileModel(
        adminTitle: adminTitle,
        adminUsername: adminUsername,
        adminEmail: adminEmail
      ));
      if (res) {
        MyToast.showSuccess(message: "Update Successfully");
      } else {
        MyToast.showError(message: "Someting Went Wrong");
      }
    }else{
      MyToast.showError(message: "Please Enter All Values");
    }
    isLoading.value = false;
  }

  Future<void> resetAdminPass({required oldPass,required newPass})async{
    if(checkResetFields()){
      final res = await ResetPassRepo().setUpdateAdminPass(oldPass: oldPass, newPass: newPass);
      if(res){
        MyToast.showSuccess(message: "Password Update Successfully");
      }
    }
  }

  bool checkResetFields(){
    if(oldPassController.text.isEmpty){
      MyToast.showError(message: "Please Enter Old Password");
      return false;
    }else if(newPassController.text.isEmpty){
      MyToast.showError(message: "Please Enter New Password");
      return false;
    }else if(confirmPassController.text.isEmpty){
      MyToast.showError(message: "Please Enter Confirm Password");
      return false;
    }else if(newPassController.text!=confirmPassController.text){
      MyToast.showError(message: "New Pass and Confirm Pass not match");
      return false;
    }
    return true;
  }

  Future<Uint8List> urlToBytes(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes; // <-- This is Uint8List
    } else {
      throw Exception("Failed to load image: ${response.statusCode}");
    }
  }
  void pickImage({required Rx<Uint8List> slider}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      // On Web, path will be null → use bytes
      slider.value = result.files.single.bytes!;
      // On Mobile/Desktop, path is available → you can create a File
      // String? path = result.files.single.path;
      if (!kIsWeb) {
        return MyToast.showError(message: "Only Supported Flutter Web");
      }
    } else {
      MyToast.showError(message: "Image not select");
    }
  }

  Future<void> updateSlider({
    required String sliderOne,
    required String sliderTwo,
    required String sliderThree,
  }) async {
    isLoading.value = true;
    if (sliderOne.isNotEmpty&&sliderTwo.isNotEmpty&&sliderThree.isNotEmpty) {
      final res = await SettingsRepo().setUpdateSettings(
        settingsModel: SettingsModel(
          id: 1,
          sliderOne: sliderOne,
          sliderTwo: sliderTwo,
          slideThree: sliderThree
        ),
      );
      if (res) {
        MyToast.showSuccess(message: "Update Successfully");
      } else {
        MyToast.showError(message: "Someting Went Wrong");
      }
    }else{
      MyToast.showError(message: "Please Select Slider");
    }
    isLoading.value = false;
  }
}
