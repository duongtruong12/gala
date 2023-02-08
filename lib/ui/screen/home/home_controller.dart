import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RxInt currentIndex = 0.obs;

  late Map<int, String> map;

  @override
  void onInit() {
    super.onInit();
    if (casterAccount.value) {
      map = <int, String>{
        RouteId.search: Routes.search,
        RouteId.message: Routes.message,
        RouteId.callFemale: Routes.callFemale,
        RouteId.myPageFemale: Routes.myPageFemale,
      };
    } else {
      map = <int, String>{
        RouteId.search: Routes.search,
        RouteId.message: Routes.message,
        RouteId.call: Routes.call,
        RouteId.myPage: Routes.myPage,
      };
    }
  }

  void onTapItem(int? index) {
    if (index == currentIndex.value) {
      return;
    }
    currentIndex.value = index ?? 0;
  }
}
