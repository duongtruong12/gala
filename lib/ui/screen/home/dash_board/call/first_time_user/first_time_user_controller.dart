import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:get/get.dart';

class FirstTimeUserController extends GetxController {
  static FirstTimeUserController get to => Get.find();

  void onPressedBack() {
    Get.back(id: RouteId.call);
  }

  Future<void> switchFirstTimeUser() async {
    Get.toNamed(Routes.confirmCall, id: RouteId.call);
  }
}
