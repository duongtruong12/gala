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
      await handleLogin();
    });
  }

  Future<void> handleLogin() async {
    if (user.value != null) {
      if (user.value?.typeAccount == TypeAccount.admin.name) {
        casterAccount.value = false;
        Get.changeTheme(lightTheme);
        await storeData(
            key: SharedPrefKey.femaleGender, value: casterAccount.value);
        Get.offAllNamed(Routes.homeAdmin, predicate: (route) => false);
      } else if (user.value?.typeAccount == TypeAccount.caster.name) {
        casterAccount.value = true;
        await storeData(
            key: SharedPrefKey.femaleGender, value: casterAccount.value);
        Get.changeTheme(femaleTheme);
        Get.offAllNamed(Routes.home, predicate: (route) => false);
      } else {
        casterAccount.value = false;
        await storeData(
            key: SharedPrefKey.femaleGender, value: casterAccount.value);
        Get.changeTheme(lightTheme);
        Get.offAllNamed(Routes.home, predicate: (route) => false);
      }
    }
  }

  Future<void> onLogin() async {
    if (formKey.currentState?.validate() == true) {
      await fireStoreProvider.loginUser(
          email: emailController.text.trim(),
          password: passController.text.trim());
      await handleLogin();
    }
  }
}
