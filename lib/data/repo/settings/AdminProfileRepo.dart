
import 'dart:convert';

import 'package:ebook_admin/data/api/apiClient.dart';
import 'package:ebook_admin/features/setting/model/AdminProfileModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;

class AdminProfileRepo{

  Future<Map<String,dynamic>?> fetchAdminProfile()async{
    try{
      final res = await http.post(Uri.parse(apiClient.adminProfileUrl));
      if(res.statusCode==200){
        return jsonDecode(res.body);
      }else{
        MyToast.showError(message: "Someting went wrong");
        return null;
      }
    }catch(e){
      MyToast.showError(message: e.toString());
      return null;
    }
  }

  Future<bool> setUpdateAdminProfile({required AdminProfileModel adminProfileModel})async{
    try{
      final res = await http.post(Uri.parse(apiClient.updateAdminProfileUrl),headers: apiClient.myHeaders, body: jsonEncode(adminProfileModel.toJson()));
      if(res.statusCode==200){
        return true;
      }else{
        MyToast.showError(message: "Someting went wrong");
        return false;
      }
    }catch(e){
      MyToast.showError(message: e.toString(),title: "API ERROR");
      return false;
    }
  }
}