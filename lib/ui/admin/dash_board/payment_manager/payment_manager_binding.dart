import 'package:get/get.dart';
import 'payment_manager_controller.dart';

class PaymentManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentManagerController>(
      () => PaymentManagerController(),
    );
  }
}
