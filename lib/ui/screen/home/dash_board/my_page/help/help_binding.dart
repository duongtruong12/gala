import 'package:get/get.dart';
import 'help_controller.dart';

class HelpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpPageController>(
      () => HelpPageController(),
    );
  }
}
