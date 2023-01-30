import 'package:get/get.dart';
import 'sale_proceed_controller.dart';

class SaleProceedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleProceedController>(
      () => SaleProceedController(),
    );
  }
}
