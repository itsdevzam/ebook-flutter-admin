import 'dart:convert';

import 'package:ebook_admin/data/api/apiClient.dart';
import 'package:ebook_admin/features/setting/model/SettingsModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;

class SettingsRepo{

  Future<Map<String,dynamic>?> fetchSettings()async{
    try{
      final res = await http.post(Uri.parse(apiClient.settingsUrl));
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

  Future<bool> setUpdateSettings({required SettingsModel settingsModel})async{
    try{
      final res = await http.post(Uri.parse(apiClient.updateSettingsUrl),headers: apiClient.myHeaders,
      body: jsonEncode(settingsModel.toJson()));
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