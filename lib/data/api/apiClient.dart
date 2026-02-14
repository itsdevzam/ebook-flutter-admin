

import 'package:ebook_admin/utils/constants.dart';

class apiClient{
  ///Base URL
  static const baseUrl = Constants.baseURL;
  ///Login
  static const loginUrl = "$baseUrl/adminlogin";
  ///HomePage Data
  static const homeUrl = "$baseUrl/adminhome";
  ///FetchUser Data
  static const userUrl = "$baseUrl/allusers";
  ///Delete User
  static const deleteUserUrl = "$baseUrl/deluserbyadmin";
  ///Settings
  static const settingsUrl = "$baseUrl/settings";
  ///Update Settings
  static const updateSettingsUrl = "$baseUrl/updatesettings";
  ///Admin Profile
  static const adminProfileUrl = "$baseUrl/adminprofile";
  ///Update Admin Profile
  static const updateAdminProfileUrl = "$baseUrl/adminupdateprofile";
  ///Reset Password
  static const resetPassUrl = "$baseUrl/updateadminpass";
  ///Ebook Categories
  static const bookCatUrl = "$baseUrl/bookcat";
  ///Add Ebook Categories
  static const addBookCatUrl = "$baseUrl/addbookcat";
  ///Edit Ebook Categories
  static const editBookCatUrl = "$baseUrl/editbookcat";
  ///Delete Ebook Categories
  static const delBookCatUrl = "$baseUrl/delbookcat";
  ///Quiz Categories
  static const quizCatUrl = "$baseUrl/quizcat";
  ///Add Quiz Categories
  static const addQuizCatUrl = "$baseUrl/addquizcat";
  ///Edit Ebook Categories
  static const editQuizCatUrl = "$baseUrl/editquizcat";
  ///Delete Ebook Categories
  static const delQuizCatUrl = "$baseUrl/delquizcat";
  ///All QUiz
  static const quizUrl = "$baseUrl/allquiz";
  ///Edit Quiz
  static const editQuizUrl = "$baseUrl/editquiz";
  ///Add Quiz
  static const addQuizUrl = "$baseUrl/addquiz";
  ///Add Quiz SubCategory
  static const addQuizSubCatUrl = "$baseUrl/addquizsubcat";
  ///All Quiz SubCat
  static const quizSubCatUrl = "$baseUrl/quizsubcat";
  ///Delete Quiz Subcat
  static const deleteQuizSubCatUrl = "$baseUrl/delquizsubcat";
  ///Delete Quiz
  static const deleteQuizUrl = "$baseUrl/deletequiz";
  ///All Books
  static const booksUrl = "$baseUrl/allbooks";
  ///Add book
  static const addBookUrl = "$baseUrl/addbook";
  ///Delete book
  static const deleteBookUrl = "$baseUrl/delbook";
  ///Edit Book
  static const editBookUrl = "$baseUrl/editbook";
  ///Seacrh User
  static const searchUserUrl = "$baseUrl/searchuser";
  ///Seacrh Book
  static const searchBookUrl = "$baseUrl/searchbook";
  ///Seacrh Quiz
  static const searchQuizUrl = "$baseUrl/searchquiz";

  ///My Header
  static const Map<String,String> myHeaders = {
  'Content-Type': 'application/json',
  };
}