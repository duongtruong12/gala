import 'package:get/get.dart';
import 'cast_payment_manager_controller.dart';

class CastPaymentManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CastPaymentManagerController>(
      () => CastPaymentManagerController(),
    );
  }
}
