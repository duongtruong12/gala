import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:get/get.dart';

class UserDetailController extends GetxController {
  static UserDetailController get to => Get.find();
  Rxn<UserModel> model = Rxn<UserModel>();
  bool? canPop;
  final currentSelect = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    canPop = Get.arguments;
    if (Get.parameters['id'] != null) {
      model.value =
          await fireStoreProvider.getUserDetail(id: Get.parameters['id']);
    } else {
      Get.offAllNamed(Routes.error);
    }
  }

  void onSwitchImage(int i) {
    currentSelect.value = i;
  }

  void onPressedBack() {
    if (canPop == true) {
      Get.back();
    } else {
      if (user.value?.typeAccount == TypeAccount.admin.name) {
        Get.offAndToNamed(Routes.homeAdmin);
      } else {
        Get.offAndToNamed(Routes.home);
      }
    }
  }
}
