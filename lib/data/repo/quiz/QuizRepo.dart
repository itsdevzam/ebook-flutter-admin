import 'dart:convert';

import 'package:ebook_admin/data/api/apiClient.dart';
import 'package:ebook_admin/features/quiz/model/QuizModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;

class QuizRepo {

  Future<Map<String,dynamic>?> fetchQuiz({required String page}) async {
    try {
      final res = await http.post(Uri.parse("${apiClient.quizUrl}?page=$page"));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        MyToast.showError(message: res.body);
        return null;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return null;
    }
  }

  Future<List<dynamic>?> fetchQuizCatList() async {
    try {
      final res = await http.post(Uri.parse(apiClient.quizCatUrl));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        MyToast.showError(message: res.body);
        return null;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return null;
    }
  }

  Future<bool> callEditQuiz({required QuizModel quizModel}) async {
    try {
      final res = await http.post(
        Uri.parse(apiClient.editQuizUrl),
        headers: apiClient.myHeaders,
        body: jsonEncode(quizModel.toJson())
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        MyToast.showError(message: res.body);
        return false;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return false;
    }
  }

  Future<bool> callAddQuiz({required QuizModel quizModel}) async {
    try {
      final res = await http.post(
          Uri.parse(apiClient.addQuizUrl),
          headers: apiClient.myHeaders,
          body: jsonEncode(quizModel.toJson())
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        MyToast.showError(message: res.body);
        return false;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return false;
    }
  }

  Future<bool> callDeleteQuiz({required int id}) async {
    try {
      final res = await http.post(
          Uri.parse(apiClient.deleteQuizUrl),
          headers: apiClient.myHeaders,
          body: jsonEncode({
            "id" : id
          })
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        MyToast.showError(message: res.body);
        return false;
      }
    } catch (e) {
      MyToast.showError(title: "API Error", message: e.toString());
      return false;
    }
  }

  Future<List<dynamic>?> searchQuiz({required String question}) async {
    try{
      final res = await http.post(Uri.parse(apiClient.searchQuizUrl),body: jsonEncode({
        "question" : question
      }),headers: apiClient.myHeaders);
      if(res.statusCode==200){
        return jsonDecode(res.body);
      }else{
        MyToast.showError(message: res.body);
        return null;
      }
    }catch(e){
      MyToast.showError(message: e.toString(),title: "API Error");
      return null;
    }
  }
}
