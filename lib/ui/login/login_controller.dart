import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      storeData(key: SharedPrefKey.femaleGender, value: false);
      casterAccount.value = false;
    });
  }

  Future<void> onLogin() async {
    if (emailController.text == 'admin@gmail.com') {
      casterAccount.value = false;
      Get.changeTheme(lightTheme);
      await storeData(
          key: SharedPrefKey.femaleGender, value: casterAccount.value);
      Get.offAllNamed(Routes.homeAdmin, predicate: (route) => false);
    } else {
      if (emailController.text == '2@gmail.com') {
        casterAccount.value = true;
        Get.changeTheme(femaleTheme);
      } else {
        casterAccount.value = false;
        Get.changeTheme(lightTheme);
      }
      await storeData(
          key: SharedPrefKey.femaleGender, value: casterAccount.value);
      Get.offAllNamed(Routes.home, predicate: (route) => false);
    }
  }
}
