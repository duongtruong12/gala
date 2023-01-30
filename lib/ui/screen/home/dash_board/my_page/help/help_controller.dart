import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class HelpPageController extends GetxController {
  static HelpPageController get to => Get.find();

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }
}
