import 'package:get/get.dart';
import 'confirm_call_controller.dart';

class ConfirmCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmCallController>(
      () => ConfirmCallController(),
    );
  }
}
