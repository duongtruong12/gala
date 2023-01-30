import 'package:get/get.dart';
import 'point_history_female_controller.dart';

class PointHistoryFemaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PointHistoryFemaleController>(
      () => PointHistoryFemaleController(),
    );
  }
}
