import 'package:get/get.dart';
import 'user_guide_controller.dart';

class UserGuideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserGuideController>(
      () => UserGuideController(),
    );
  }
}
