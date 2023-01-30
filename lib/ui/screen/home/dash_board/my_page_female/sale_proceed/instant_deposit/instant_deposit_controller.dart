import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class InstantDepositController extends GetxController {
  static InstantDepositController get to => Get.find();

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }
}
