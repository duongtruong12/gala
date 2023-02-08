import 'package:get/get.dart';
import 'call_list_controller.dart';

class CallListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallListController>(
      () => CallListController(),
    );
  }
}
