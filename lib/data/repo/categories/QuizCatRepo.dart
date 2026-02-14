
import 'dart:convert';

import 'package:ebook_admin/data/api/apiClient.dart';
import 'package:ebook_admin/features/categories/model/QuizCatModel.dart';
import 'package:ebook_admin/features/categories/model/QuizSubCatModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;

class QuizCatRepo{
  Future<List?> fetchQuizCat() async {
    try {
      final res = await http.post(Uri.parse(apiClient.quizCatUrl));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        MyToast.showError(message: "Quiz Categories Data Error");
        return null;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return null;
    }
  }

  Future<List?> fetchQuizSubCat({required String categoryId}) async {
    try {
      final res = await http.post(Uri.parse("${apiClient.quizSubCatUrl}?category_id=$categoryId"));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        MyToast.showError(message: "Quiz Sub Categories Data Error");
        return null;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return null;
    }
  }

  Future<bool> addQuizCat({required String name}) async {
    try {
      final res = await http.post(
        Uri.parse(apiClient.addQuizCatUrl),
        headers: apiClient.myHeaders,
        body: jsonEncode(QuizCatModel(name: name)),
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        MyToast.showError(message: "Quiz Categories Data Error");
        return false;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return false;
    }
  }

  Future<bool> addQuizSubCat({required String name,required String categoryId}) async {
    try {
      final res = await http.post(
        Uri.parse(apiClient.addQuizSubCatUrl),
        headers: apiClient.myHeaders,
        body: jsonEncode(QuizSubCatModel(name: name,categoryId: int.parse(categoryId))),
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        MyToast.showError(message: "Quiz Categories Data Error");
        return false;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return false;
    }
  }

  Future<bool> editQuizCat({required QuizCatModel quizCatModel}) async {
    try {
      final res = await http.post(
        Uri.parse(apiClient.editQuizCatUrl),
        headers: apiClient.myHeaders,
        body: jsonEncode(quizCatModel.toJson()),
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

  Future<bool> delQuizCat({required int id}) async {
    try {
      final res = await http.post(
        Uri.parse(apiClient.delQuizCatUrl),
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

  Future<bool> delQuizSubCat({required int id}) async {
    try {
      final res = await http.post(
        Uri.parse(apiClient.deleteQuizSubCatUrl),
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