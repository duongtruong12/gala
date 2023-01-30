import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class SaleProceedController extends GetxController {
  static SaleProceedController get to => Get.find();

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }

  void switchTransferInformation() {
    Get.toNamed(Routes.transferInformation, id: getRouteMyPage());
  }

  void switchInstantDeposit() {
    Get.toNamed(Routes.instantDeposit, id: getRouteMyPage());
  }
}
