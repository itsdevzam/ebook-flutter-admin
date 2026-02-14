import 'package:ebook_admin/data/repo/categories/QuizCatRepo.dart';
import 'package:ebook_admin/data/repo/quiz/QuizRepo.dart';
import 'package:ebook_admin/features/categories/controller/CategoriesController.dart';
import 'package:ebook_admin/features/categories/model/QuizCatModel.dart';
import 'package:ebook_admin/features/categories/model/QuizSubCatModel.dart';
import 'package:ebook_admin/features/quiz/model/QuizModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  RxString QuizInitOptionValue = "A".obs;

  ///for correct option
  RxInt QuizInitCatValue = 0.obs;
  RxInt QuizInitSubCatValue = 0.obs;

  ///for correct option
  RxList<QuizModel> quizModelList = RxList();
  RxMap<int, String> quizCatListMap = RxMap();
  RxMap<int, String> quizSubCatListMap = RxMap();

  RxBool isLoading = false.obs;
  RxBool isLoadingForCategories = false.obs;

  ///Text Controllers
  TextEditingController questionController = TextEditingController();
  TextEditingController answerA = TextEditingController();
  TextEditingController answerB = TextEditingController();
  TextEditingController answerC = TextEditingController();
  TextEditingController answerD = TextEditingController();
  TextEditingController explanationController = TextEditingController();


  TextEditingController searchQuizController = TextEditingController();

  ///for footer
  RxString currentPage = "".obs;
  RxString totalPage = "".obs;

  void getQuiz({required String page}) async {
    try {
      isLoading.value = true;
      await getQuizCatList();
      await getQuizSubCatList(categoryId: "");
      final response = await QuizRepo().fetchQuiz(page: page);
      if (response != null) {
        try {
          currentPage.value = response["page"].toString();
          totalPage.value = response["totalPages"].toString();
          List<dynamic> quizList = response["data"];
          quizModelList.value = RxList(
            quizList.map((e) => QuizModel.fromJson(e)).toList(),
          );
          isLoading.value = false;
        } catch (e) {
          MyToast.showError(message: e.toString());
          isLoading.value = false;
        } finally {
          isLoading.value = false;
        }
      }
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getQuizCatList() async {
    try {
      isLoadingForCategories.value = true;
      final response = await QuizRepo().fetchQuizCatList();
      if (response != null) {
        ///convert id to category name
        List<QuizCatModel> quizCatModelList = RxList(
          response.map((e) => QuizCatModel.fromJson(e)).toList(),
        );
        quizCatListMap.value = {for (var e in quizCatModelList) e.id!: e.name!};
      }
      isLoadingForCategories.value = false;
    } finally {
      isLoadingForCategories.value = false;
    }
  }

  Future<void> getQuizSubCatList({required String categoryId}) async {
    try {
      isLoadingForCategories.value = true;
      final response = await QuizCatRepo().fetchQuizSubCat(categoryId: categoryId);
      if (response != null) {
        ///convert id to category name
        List<QuizSubCatModel> quizSubCatModelList = RxList(response.map((e) => QuizSubCatModel.fromJson(e)).toList(),
        );
        quizSubCatListMap.value = {for (var e in quizSubCatModelList) e.id!: e.name!};
      }
      isLoadingForCategories.value = false;
    } finally {
      isLoadingForCategories.value = false;
    }
  }

  Future<void> editQuiz({required QuizModel quizModel}) async {
    try {
      isLoading.value = true;
      final response = await QuizRepo().callEditQuiz(quizModel: quizModel);
      if (response) {
        MyToast.showSuccess(message: "Quiz Edit Successfully");
        getQuiz(page: currentPage.value); //to refresh list
      }
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addQuiz({required QuizModel quizModel}) async {
    try {
      isLoading.value = true;
      final response = await QuizRepo().callAddQuiz(quizModel: quizModel);
      if (response) {
        MyToast.showSuccess(message: "Quiz Added Successfully");
        getQuiz(page: currentPage.value); //to refresh list
      }
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteQuiz({required int id}) async {
    try {
      isLoading.value = true;
      final response = await QuizRepo().callDeleteQuiz(id: id);
      if (response) {
        MyToast.showSuccess(message: "Quiz Deleted Successfully");
        getQuiz(page: currentPage.value); //to refresh list
      }
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  bool checkFields() {
    if (questionController.text.isEmpty) {
      return false;
    } else if (answerA.text.isEmpty) {
      return false;
    } else if (answerB.text.isEmpty) {
      return false;
    } else if (answerC.text.isEmpty) {
      return false;
    } else if (answerD.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> searchQuiz({required String question})async{
    isLoading.value = true;
    final response = await QuizRepo().searchQuiz(question: question);
    if(response!=null){
      quizModelList.value = RxList(response.map((e)=>QuizModel.fromJson(e)).toList());
    }
    isLoading.value = false;
  }
}
