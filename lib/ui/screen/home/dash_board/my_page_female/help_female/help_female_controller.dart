import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class HelpFemaleController extends GetxController {
  static HelpFemaleController get to => Get.find();

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }

  void switchFaq() {
    Get.toNamed(Routes.userGuide, id: getRouteMyPage());
  }

  void switchTerm() {
    Get.toNamed(Routes.term, arguments: true);
  }

  void switchLaw() {
    Get.toNamed(Routes.law, arguments: true);
  }

  void switchPrivacy() {
    Get.toNamed(Routes.privacyPolicy, arguments: true);
  }
}
