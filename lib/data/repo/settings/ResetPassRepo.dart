
import 'dart:convert';

import 'package:ebook_admin/data/api/apiClient.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;

class ResetPassRepo {
  Future<bool> setUpdateAdminPass({required String oldPass , required String newPass})async{
    try{
      final res = await http.post(Uri.parse(apiClient.resetPassUrl),headers: apiClient.myHeaders, body: jsonEncode({
        "old_pass" : oldPass,
        "new_pass" : newPass
      }));
      if(res.statusCode==200){
        return true;
      }else{
        MyToast.showError(message: res.body);
        return false;
      }
    }catch(e){
      MyToast.showError(message: e.toString(),title: "API ERROR");
      return false;
    }
  }
}