import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:get/get.dart';

class HomeAdminController extends GetxController {
  static HomeAdminController get to => Get.find();
  RxInt currentIndex = 0.obs;

  final Map<int, String> map = <int, String>{
    RouteIdAdmin.casterManager: Routes.casterManager,
    RouteIdAdmin.guestManager: Routes.guestManager,
    RouteIdAdmin.chatManager: Routes.chatManager,
    RouteIdAdmin.paymentManager: Routes.paymentManager,
    RouteIdAdmin.castPaymentManager: Routes.castPaymentManager,
    RouteIdAdmin.callList: Routes.callList,
  };

  void onTapItem(int? index) {
    if (index == currentIndex.value) {
      return;
    }
    currentIndex.value = index ?? 0;
  }
}
