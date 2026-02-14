import 'dart:convert';

import 'package:ebook_admin/features/categories/model/EbookCatModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;
import '../../api/apiClient.dart';

class BookCatRepo {
  Future<List?> fetchBookCat() async {
    try {
      final res = await http.post(Uri.parse(apiClient.bookCatUrl));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        MyToast.showError(message: "Book Categories Data Error");
        return null;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return null;
    }
  }

  Future<bool> addBookCat({required String name}) async {
    try {
      final res = await http.post(
        Uri.parse(apiClient.addBookCatUrl),
        headers: apiClient.myHeaders,
        body: jsonEncode(EbookCatModel(name: name)),
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        MyToast.showError(message: res.body.toString());
        return false;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return false;
    }
  }

  Future<bool> editBookCat({required EbookCatModel ebookCatModel}) async {
    try {
      final res = await http.post(
        Uri.parse(apiClient.editBookCatUrl),
        headers: apiClient.myHeaders,
        body: jsonEncode(ebookCatModel.toJson()),
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        MyToast.showError(message: res.body.toString());
        return false;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return false;
    }
  }

  Future<bool> delBookCat({required int id}) async {
    try {
      final res = await http.post(
        Uri.parse(apiClient.delBookCatUrl),
        headers: apiClient.myHeaders,
        body: jsonEncode({
          "id" : id
        }),
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        MyToast.showError(message: res.body.toString());
        return false;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return false;
    }
  }
}
