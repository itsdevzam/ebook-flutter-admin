
import 'dart:async';

import 'package:ebook_admin/data/repo/categories/BookCatRepo.dart';
import 'package:ebook_admin/data/repo/categories/QuizCatRepo.dart';
import 'package:ebook_admin/features/categories/model/EbookCatModel.dart';
import 'package:ebook_admin/features/categories/model/QuizCatModel.dart';
import 'package:ebook_admin/features/categories/model/QuizSubCatModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController{
  RxBool isLoading = false.obs;
  RxList<EbookCatModel> ebookModeList = RxList();
  TextEditingController bookCatTextController = TextEditingController();
  TextEditingController bookCatEditTextController = TextEditingController();
  ///For Quiz
  RxList<QuizCatModel> quizModeList = RxList();
  RxList<QuizSubCatModel> quizSubCatModeList = RxList();
  TextEditingController quizCatTextController = TextEditingController();
  TextEditingController quizSubCatTextController = TextEditingController();
  TextEditingController quizCatEditTextController = TextEditingController();

  Future<void>  getBookCat()async{
   try{
     isLoading.value=true;
     final res = await BookCatRepo().fetchBookCat();
     List<dynamic> catList = res as List;
     ebookModeList = RxList(catList.map((e)=>EbookCatModel.fromJson(e)).toList());
     isLoading.value=false;
   }catch(e){
     MyToast.showError(message: e.toString());
     isLoading.value=false;
   }
  }

  Future<void>  addBookCat({required String name})async{
    try{
      isLoading.value=true;
      if(bookCatTextController.text.isEmpty){
        isLoading.value=false;
        return MyToast.showError(message: "Category Field Empty");
      }else{
        final res = await BookCatRepo().addBookCat(name: name);
        if(res){
          MyToast.showSuccess(message: "Category Added Successfully");
          Timer(Duration(seconds: 1),()=>getBookCat());
          bookCatTextController.text="";
        }
      }
      isLoading.value=false;
    }catch(e){
      MyToast.showError(message: e.toString());
      isLoading.value=false;
    }
  }

  Future<void> editBookCat({required EbookCatModel ebookCatModel})async{
    try{
      isLoading.value=true;
      if(bookCatEditTextController.text.isEmpty){
        isLoading.value=false;
        return MyToast.showError(message: "Category Field Empty");
      }else{
        final res = await BookCatRepo().editBookCat(ebookCatModel: ebookCatModel);
        if(res){
          MyToast.showSuccess(message: "Category Edited Successfully");
          Timer(Duration(seconds: 1),()=>getBookCat());
          bookCatTextController.text="";
        }
      }
      isLoading.value=false;
    }catch(e){
      MyToast.showError(message: e.toString());
      isLoading.value=false;
    }
  }

  Future<void> delBookCat({required int id})async{
    try{
      isLoading.value=true;
      final res = await BookCatRepo().delBookCat(id: id);
      if(res){
        MyToast.showSuccess(message: "Category Deleted Successfully");
        Timer(Duration(seconds: 1),()=>getBookCat());
      }
      isLoading.value=false;
    }catch(e){
      MyToast.showError(message: e.toString());
      isLoading.value=false;
    }
  }

  Future<void>  getQuizCat()async{
    try{
      isLoading.value=true;
      final res = await QuizCatRepo().fetchQuizCat();
      List<dynamic> catList = res as List;
      quizModeList = RxList(catList.map((e)=>QuizCatModel.fromJson(e)).toList());
      isLoading.value=false;
    }catch(e){
      MyToast.showError(message: e.toString());
      isLoading.value=false;
    }
  }
  Future<void>  getQuizSubCat({required String categoryId})async{
    try{
      final res = await QuizCatRepo().fetchQuizSubCat(categoryId: categoryId);
      List<dynamic> catList = res as List;
      quizSubCatModeList = RxList(catList.map((e)=>QuizSubCatModel.fromJson(e)).toList());
    }catch(e){
      MyToast.showError(message: e.toString());
    }
  }

  Future<void>  addQuizCat({required String name})async{
    try{
      isLoading.value=true;
      if(quizCatTextController.text.isEmpty){
        isLoading.value=false;
        return MyToast.showError(message: "Category Field Empty");
      }else{
        final res = await QuizCatRepo().addQuizCat(name: name);
        if(res){
          MyToast.showSuccess(message: "Category Added Successfully");
          Timer(Duration(seconds: 1),()=>getQuizCat());
          quizCatTextController.text="";
        }
      }
      isLoading.value=false;
    }catch(e){
      MyToast.showError(message: e.toString());
      isLoading.value=false;
    }
  }

  Future<void>  addQuizSubCat({required String name,required String categoryId})async{
    try{
      isLoading.value=true;
      if(quizSubCatTextController.text.isEmpty){
        isLoading.value=false;
        return MyToast.showError(message: "SubCategory Field Empty");
      }else{
        final res = await QuizCatRepo().addQuizSubCat(name: name,categoryId: categoryId);
        if(res){
          MyToast.showSuccess(message: "Category Added Successfully");
          Timer(Duration(seconds: 1),()=>getQuizCat());
          quizSubCatTextController.text="";
        }
      }
      isLoading.value=false;
    }catch(e){
      MyToast.showError(message: e.toString());
      isLoading.value=false;
    }
  }

  Future<void> editQuizCat({required QuizCatModel quizCatModel})async{
    try{
      isLoading.value=true;
      if(quizCatEditTextController.text.isEmpty){
        isLoading.value=false;
        return MyToast.showError(message: "Category Field Empty");
      }else{
        final res = await QuizCatRepo().editQuizCat(quizCatModel: quizCatModel);
        if(res){
          MyToast.showSuccess(message: "Category Edited Successfully");
          Timer(Duration(seconds: 1),()=>getQuizCat());
          bookCatTextController.text="";
        }
      }
      isLoading.value=false;
    }catch(e){
      MyToast.showError(message: e.toString());
      isLoading.value=false;
    }
  }

  Future<void> delQuizCat({required int id})async{
    try{
      isLoading.value=true;
      final res = await QuizCatRepo().delQuizCat(id: id);
      if(res){
        MyToast.showSuccess(message: "Category Deleted Successfully");
        Timer(Duration(seconds: 1),()=>getQuizCat());
      }
      isLoading.value=false;
    }catch(e){
      MyToast.showError(message: e.toString());
      isLoading.value=false;
    }
  }
  Future<void> delQuizSubCat({required int id})async{
    try{
      isLoading.value=true;
      final res = await QuizCatRepo().delQuizSubCat(id: id);
      if(res){
        MyToast.showSuccess(message: "SubCat Deleted Successfully");
        Timer(Duration(seconds: 1),()=>getQuizCat());
      }
      isLoading.value=false;
    }catch(e){
      MyToast.showError(message: e.toString());
      isLoading.value=false;
    }
  }
}