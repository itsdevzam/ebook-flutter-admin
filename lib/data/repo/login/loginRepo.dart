import 'dart:convert';

import 'package:ebook_admin/data/api/apiClient.dart';
import 'package:ebook_admin/features/auth/model/loginModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;

class LoginRepo {

  Future<Map<String, dynamic>?> loginNow({required email,required password}) async {
    try{
      final model = loginModel(email: email,password: password);
      final res = await http.post(Uri.parse(apiClient.loginUrl), body: jsonEncode(model.toJson()),headers: apiClient.myHeaders);
      if(res.statusCode==200){
        return jsonDecode(res.body);
      }else{
        MyToast.showError(message: res.body);
        return null;
      }
    }catch(e){
      MyToast.showError(title: "API Error", message: e.toString());
    }
    return null;
  }

}
