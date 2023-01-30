import 'package:get/get.dart';
import 'help_female_controller.dart';

class HelpFemaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpFemaleController>(
      () => HelpFemaleController(),
    );
  }
}
