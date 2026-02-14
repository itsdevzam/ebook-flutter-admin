import 'dart:convert';

import 'package:ebook_admin/data/api/apiClient.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;
class HomeRepo{
  
  Future<Map<String,dynamic>?> fetchHomePageData()async{
    try{
      final res = await http.post(Uri.parse(apiClient.homeUrl));
      if(res.statusCode==200){
        return jsonDecode(res.body);
      }else{
        MyToast.showError(message: "HomePage Data Error");
        return null;
      }
    }catch(e){
      MyToast.showError(title: "API Error",message: e.toString());
      return null;
    }
  }
  
}