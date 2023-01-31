import 'package:get/get.dart';
import 'right_controller.dart';

class RightTermBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RightTermController>(
      () => RightTermController(),
    );
  }
}
