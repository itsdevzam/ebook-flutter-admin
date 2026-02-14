import 'dart:convert';
import 'package:ebook_admin/data/repo/ebook/EbookRepo.dart';
import 'package:ebook_admin/features/categories/model/EbookCatModel.dart';
import 'package:ebook_admin/features/ebook/model/EbookModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;

class EbookController extends GetxController {
  RxInt ebookInitOptionValue = 0.obs;
  RxInt ebookCatOptionValue = 0.obs;
  RxBool isLoading = false.obs;
  RxList<EbookModel> ebookModelList = RxList();
  RxMap<int, String> ebookCatListMap = RxMap();
  RxString currentPage = "".obs;
  RxString totalPage = "".obs;
  RxString pdfFileName = "".obs;

  ///for image
  Uint8List? imageBytes = Uint8List(0);
  Uint8List? pdfBytes = Uint8List(0);
  RxBool isImagePicked = false.obs;
  RxBool isPdfPicked = false.obs;
  RxBool isCatLoadingForDropDown = false.obs;

  ///for add EBook
  TextEditingController titleTextController = TextEditingController();
  TextEditingController urlTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();

  TextEditingController searchEbookController = TextEditingController();

  Future<void> allEbooksData({required String page}) async {
    isLoading.value = true;
    final response = await EbookRepo().fetchAllEBooks(page: page);
    await getBookCatList();
    if (response != null) {
      try {
        currentPage.value = response["page"].toString();
        totalPage.value = response["totalPages"].toString();
        List<dynamic> userList = response["data"];
        ebookModelList.value = userList
            .map((e) => EbookModel.fromJson(e))
            .toList();
        isLoading.value = false;
      } catch (e) {
        MyToast.showError(message: e.toString());
        isLoading.value = false;
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> getBookCatList() async {
    try {
      isCatLoadingForDropDown.value = true;
      final response = await EbookRepo().fetchBookCat();
      if (response != null) {
        ///convert id to category name
        List<EbookCatModel> ebookCatModelList = RxList(
          response.map((e) => EbookCatModel.fromJson(e)).toList(),
        );
        ebookCatListMap.value = {
          for (var e in ebookCatModelList) e.id!: e.name!,
        };
      }
      isCatLoadingForDropDown.value = false;
    } finally {
      isCatLoadingForDropDown.value = false;
    }
  }

  Future<void> deleteBook({required String id}) async {
    try {
      isLoading.value = true;
      final response = await EbookRepo().deleteBook(id: id);
      if (response) {
        MyToast.showSuccess(message: "Ebook Deleted Successfully");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addEbook({
    required Uint8List imageBytes,
    required Uint8List pdfBytes,
    required EbookModel ebookModel,
  }) async {
    try {
      isLoading.value = true;
      if (checkFields()) {
        final response = await EbookRepo().addEBook(
          base64Img: base64Encode(imageBytes),
          ebookModel: ebookModel,
          pdfBytes: pdfBytes,
        );
        if (response) {
          MyToast.showSuccess(message: "Ebook Added Successfully");
        }
      } else {
        checkFields();
      }
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editEbook({required Uint8List imageBytes, required EbookModel ebookModel,}) async {
    try {
      isLoading.value = true;
      if (checkFields()) {
        final response = await EbookRepo().editEBook(
          base64Img: base64Encode(imageBytes),
          ebookModel: ebookModel,
        );
        if (response) {
          MyToast.showSuccess(message: "Ebook Edit Successfully");
        }
      } else {
        checkFields();
      }
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      isImagePicked.value = true;
      // On Web, path will be null → use bytes
      imageBytes = result.files.single.bytes;
      // On Mobile/Desktop, path is available → you can create a File
      // String? path = result.files.single.path;
      if (!kIsWeb) {
        return MyToast.showError(message: "Only Supported Flutter Web");
      }
    } else {
      isImagePicked.value = false;
      MyToast.showError(message: "Image not select");
    }
  }

  void pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf']
    );
    if (result != null) {
      isPdfPicked.value = true;
      // On Web, path will be null → use bytes
      pdfBytes = result.files.single.bytes;
      pdfFileName.value = result.files.single.name;
      // On Mobile/Desktop, path is available → you can create a File
      // String? path = result.files.single.path;
      if (!kIsWeb) {
        return MyToast.showError(message: "Only Supported Flutter Web");
      }
    } else {
      isPdfPicked.value = false;
      MyToast.showError(message: "Ebook Pdf not select");
    }
  }

  bool checkFields() {
    if (!isImagePicked.value) {
      MyToast.showError(message: "Please Pick Image");
      return false;
    } else if (titleTextController.text.isEmpty) {
      MyToast.showError(message: "Please Enter Title");
      return false;
    } else if (descTextController.text.isEmpty) {
      MyToast.showError(message: "Please Enter Description");
      return false;
    } else if(!isPdfPicked.value){
      MyToast.showError(message: "Please Pick Pdf");
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

  Future<void> searchBook({required String title})async{
    isLoading.value = true;
    final response = await EbookRepo().searchBook(title: title);
    if(response!=null){
      ebookModelList.value = RxList(response.map((e)=>EbookModel.fromJson(e)).toList());
    }
    isLoading.value = false;
  }

  void openInNewTab(String url) {
    web.window.open(url, '_blank');
    // html.window.open(url, '_blank');
  }
}
