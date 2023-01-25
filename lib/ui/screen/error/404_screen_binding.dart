import 'package:get/get.dart';
import '404_page_controller.dart';

class ErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ErrorController>(
      () => ErrorController(),
    );
  }
}
