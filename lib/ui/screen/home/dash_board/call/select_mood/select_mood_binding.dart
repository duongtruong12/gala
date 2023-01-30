import 'package:get/get.dart';
import 'select_mood_controller.dart';

class SelectMoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectMoodController>(
      () => SelectMoodController(),
    );
  }
}
