import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class TransferInformationController extends GetxController {
  static TransferInformationController get to => Get.find();

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }
}
