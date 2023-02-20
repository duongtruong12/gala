import 'package:get/get.dart';
import 'search_call_controller.dart';

class SearchCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchCallController>(
      () => SearchCallController(),
    );
  }
}
