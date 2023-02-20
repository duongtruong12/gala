import 'dart:async';

import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RxInt currentIndex = 0.obs;

  late Map<int, String> map;
  StreamSubscription? streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    if (user.value?.id != null) {
      streamSubscription =
          fireStoreProvider.listenerCurrentUser(id: user.value!.id!);
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        if (user.value?.typeAccount == TypeAccount.caster.name) {
          casterAccount.value = true;
          Get.changeTheme(femaleTheme);
        } else {
          casterAccount.value = false;
          Get.changeTheme(lightTheme);
        }
        await storeData(
            key: SharedPrefKey.femaleGender, value: casterAccount.value);
      });
    }

    if (casterAccount.value) {
      map = <int, String>{
        RouteIdFemale.search: Routes.search,
        RouteIdFemale.message: Routes.message,
        RouteIdFemale.call: Routes.callFemale,
        RouteIdFemale.myPage: Routes.myPageFemale,
      };
    } else {
      map = <int, String>{
        RouteId.search: Routes.search,
        RouteId.message: Routes.message,
        RouteId.call: Routes.call,
        RouteId.myPage: Routes.myPage,
      };
    }
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  void onTapItem(int? index) {
    if (index == currentIndex.value) {
      return;
    }
    currentIndex.value = index ?? 0;
  }
}
