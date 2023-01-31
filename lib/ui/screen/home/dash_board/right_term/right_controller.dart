import 'package:base_flutter/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RightTermController extends GetxController {
  static RightTermController get to => Get.find();
  bool? canPop;

  @override
  void onInit() {
    super.onInit();
    canPop = Get.arguments;
  }

  void onPressedBack() {
    if (canPop == true) {
      Get.back();
    } else {
      Get.offAndToNamed(Routes.home);
    }
  }

  Future<String> getFileData(String label) async {
    try {
      return await rootBundle.loadString('json/$label.txt');
    } catch (e) {
      return '';
    }
  }
}
