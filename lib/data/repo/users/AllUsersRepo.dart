import 'dart:convert';

import 'package:ebook_admin/data/api/apiClient.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;
class AllUsersRepo{

  Future<Map<String,dynamic>?> fetchAllUser({required String page})async{
    try{
      final res = await http.post(Uri.parse("${apiClient.userUrl}?page=$page"));
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

  Future<bool> deleteUser({required String uid}) async {
    try{
      final res = await http.post(Uri.parse(apiClient.deleteUserUrl),body: jsonEncode({
        "uid" : uid
      }),headers: apiClient.myHeaders);
      if(res.statusCode==200){
        return true;
      }else{
        MyToast.showError(message: res.body);
        return false;
      }
    }catch(e){
      MyToast.showError(message: e.toString(),title: "API Error");
      return false;
    }
  }

  Future<List<dynamic>?> searchUser({required String email}) async {
    try{
      final res = await http.post(Uri.parse(apiClient.searchUserUrl),body: jsonEncode({
        "email" : email
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