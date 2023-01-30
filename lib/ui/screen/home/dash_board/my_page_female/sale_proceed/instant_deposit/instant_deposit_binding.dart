import 'package:get/get.dart';
import 'instant_deposit_controller.dart';

class InstantDepositBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InstantDepositController>(
      () => InstantDepositController(),
    );
  }
}
