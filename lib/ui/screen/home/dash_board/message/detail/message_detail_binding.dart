import 'package:get/get.dart';
import 'message_detail_controller.dart';

class MessageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageDetailController>(
      () => MessageDetailController(),
    );
  }
}
