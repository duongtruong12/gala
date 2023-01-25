import 'package:get/get.dart';
import 'female_detail_controller.dart';

class FemaleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FemaleDetailController>(
      () => FemaleDetailController(),
    );
  }
}
