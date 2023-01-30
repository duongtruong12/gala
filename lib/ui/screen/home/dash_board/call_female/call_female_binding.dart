import 'package:get/get.dart';
import 'call_female_controller.dart';

class CallFemaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallFemaleController>(
      () => CallFemaleController(),
    );
  }
}
