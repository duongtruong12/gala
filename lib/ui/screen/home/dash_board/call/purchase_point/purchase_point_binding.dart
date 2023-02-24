import 'package:get/get.dart';
import 'purchase_point_controller.dart';

class PurchasePointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchasePointController>(
      () => PurchasePointController(),
    );
  }
}
