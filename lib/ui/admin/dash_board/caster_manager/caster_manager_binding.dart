import 'package:get/get.dart';
import 'caster_manager_controller.dart';

class CasterManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CasterManagerController>(
      () => CasterManagerController(),
    );
  }
}
