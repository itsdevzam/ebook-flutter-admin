
import 'dart:convert';
import 'dart:typed_data';
import 'package:ebook_admin/data/api/apiClient.dart';
import 'package:http_parser/http_parser.dart';

import 'package:ebook_admin/features/ebook/model/EbookModel.dart';
import 'package:ebook_admin/helper/MyToast.dart';
import 'package:http/http.dart' as http;

class EbookRepo{

  Future<Map<String,dynamic>?> fetchAllEBooks({required String page}) async {
    try {
      final res = await http.post(Uri.parse("${apiClient.booksUrl}?page=$page"));
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

  Future<bool> addEBook({
    required String base64Img,
    required EbookModel ebookModel,
    required Uint8List pdfBytes, // 👈 must provide PDF
  }) async {
    try {
      final uri = Uri.parse(apiClient.addBookUrl);
      final request = http.MultipartRequest('POST', uri);

      // 🧾 Add headers (auth token, etc.)
      request.headers.addAll(apiClient.myHeaders);

      // 🏷️ Add text fields (meta info)
      request.fields['title'] = ebookModel.title ?? '';
      request.fields['is_paid'] = ebookModel.isPaid.toString();
      request.fields['category_id'] = ebookModel.categoryId.toString();
      request.fields['description'] = ebookModel.description ?? '';
      request.fields['imagebase64'] = base64Img;

      // 📘 Attach the PDF file
      request.files.add(http.MultipartFile.fromBytes(
        'pdf', // must match multer.single("pdf") in Node.js
        pdfBytes as List<int>, // ✅ Uint8List is fine here
        filename: '${DateTime.now().millisecondsSinceEpoch}.pdf',
        contentType: MediaType('application', 'pdf'),
      ));


      // 🚀 Send request
      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);

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

  Future<bool> editEBook({required String base64Img,required EbookModel ebookModel}) async {
    try {
      final res = await http.post(Uri.parse(apiClient.editBookUrl),headers: apiClient.myHeaders,
          body: jsonEncode({
            "id" : ebookModel.id,
            "title" : ebookModel.title,
            "imagebase64" : base64Img,
            "url"   : ebookModel.url,
            "is_paid": ebookModel.isPaid.toString(),
            "category_id" : ebookModel.categoryId.toString(),
            "description" : ebookModel.description
          }));
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

  Future<List<dynamic>?> fetchBookCat() async {
    try {
      final res = await http.post(Uri.parse(apiClient.bookCatUrl));
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

  Future<bool> deleteBook({required String id}) async {
    try {
      final res = await http.post(Uri.parse(apiClient.deleteBookUrl),headers: apiClient.myHeaders,
      body: jsonEncode({
        "id" : id
      }));
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

  Future<List<dynamic>?> searchBook({required String title}) async {
    try{
      final res = await http.post(Uri.parse(apiClient.searchBookUrl),body: jsonEncode({
        "title" : title
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