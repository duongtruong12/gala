import 'package:get/get.dart';
import 'first_time_user_controller.dart';

class FirstTimeUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstTimeUserController>(
      () => FirstTimeUserController(),
    );
  }
}
