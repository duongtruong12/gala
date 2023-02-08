import 'package:get/get.dart';
import 'chat_manager_controller.dart';

class ChatManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatManagerController>(
      () => ChatManagerController(),
    );
  }
}
