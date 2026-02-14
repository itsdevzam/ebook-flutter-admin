import 'package:ebook_admin/data/repo/home/HomeRepo.dart';
import 'package:ebook_admin/features/home/model/HomeModel.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<HomeModel> homeModel = HomeModel().obs;
  RxBool isLoading = false.obs;

  void fetchHomepage() async {
    try {
      isLoading.value = true;
      final response = await HomeRepo().fetchHomePageData();
      if (response != null) {
        isLoading.value = false;
        homeModel.value = HomeModel.fromJson(response);
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchHomepage();
  }
}
