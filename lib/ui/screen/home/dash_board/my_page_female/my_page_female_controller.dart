import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class MyPageFemaleController extends GetxController {
  static MyPageFemaleController get to => Get.find();

  void switchEditProfile() {
    Get.toNamed(Routes.editProfile, id: getRouteMyPage());
  }

  void switchPointHistory() {
    Get.toNamed(Routes.pointHistoryFemale, id: getRouteMyPage());
  }

  void switchSaleProceed() {
    Get.toNamed(Routes.saleProceed, id: getRouteMyPage());
  }

  void switchUserGuide() {
    Get.toNamed(Routes.userGuideFemale, id: getRouteMyPage());
  }

  void switchHelp() {
    Get.toNamed(Routes.helpFemale, id: getRouteMyPage());
  }
}
