import 'package:get/get.dart';
import 'my_page_female_controller.dart';

class MyPageFemaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPageFemaleController>(
      () => MyPageFemaleController(),
    );
  }
}
