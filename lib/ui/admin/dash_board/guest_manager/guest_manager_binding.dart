import 'package:get/get.dart';
import 'guest_manager_controller.dart';

class GuestManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestManagerController>(
      () => GuestManagerController(),
    );
  }
}
