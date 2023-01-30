import 'package:get/get.dart';
import 'payment_information_controller.dart';

class PaymentInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentInformationController>(
      () => PaymentInformationController(),
    );
  }
}
