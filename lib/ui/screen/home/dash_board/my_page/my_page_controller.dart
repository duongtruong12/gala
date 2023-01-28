import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:get/get.dart';

class MyPageController extends GetxController {
  static MyPageController get to => Get.find();

  void switchEditProfile() {
    Get.toNamed(Routes.editProfile, id: RouteId.myPage);
  }
}
