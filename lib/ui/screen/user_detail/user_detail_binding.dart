import 'package:get/get.dart';
import 'user_detail_controller.dart';

class UserDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailController>(
      () => UserDetailController(),
    );
  }
}
