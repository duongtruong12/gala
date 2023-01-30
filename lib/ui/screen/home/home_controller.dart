import 'package:base_flutter/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RxInt currentIndex = 0.obs;
  final pages = <String>[
    Routes.search,
    Routes.message,
    Routes.call,
    Routes.myPage,
  ];

  void onTapItem(int? index) {
    if (index == currentIndex.value) {
      return;
    }
    currentIndex.value = index ?? 0;
  }
}
