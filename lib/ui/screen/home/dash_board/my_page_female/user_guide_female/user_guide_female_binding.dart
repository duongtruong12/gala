import 'package:get/get.dart';
import 'user_guide_female_controller.dart';

class UserGuideFemaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserGuideFemaleController>(
      () => UserGuideFemaleController(),
    );
  }
}
