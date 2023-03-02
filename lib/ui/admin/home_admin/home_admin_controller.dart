import 'dart:async';

import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:get/get.dart';

class HomeAdminController extends GetxController {
  static HomeAdminController get to => Get.find();
  RxInt currentIndex = 0.obs;
  StreamSubscription? streamSubscription, steamNotification;

  final Map<int, String> map = <int, String>{
    RouteIdAdmin.casterManager: Routes.casterManager,
    RouteIdAdmin.guestManager: Routes.guestManager,
    RouteIdAdmin.chatManager: Routes.chatManager,
    // RouteIdAdmin.paymentManager: Routes.paymentManager,
    RouteIdAdmin.castPaymentManager: Routes.castPaymentManager,
    RouteIdAdmin.callList: Routes.callList,
  };

  @override
  void onInit() async {
    super.onInit();
    streamSubscription =
        fireStoreProvider.listenerCurrentUser(id: user.value!.id!);
    await fireStoreProvider.installNotification();
    steamNotification = fireStoreProvider.listenNotification();
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    steamNotification?.cancel();
    super.onClose();
  }

  void onTapItem(int? index) {
    if (index == currentIndex.value) {
      return;
    }
    currentIndex.value = index ?? 0;
  }
}
