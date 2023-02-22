import 'package:base_flutter/model/point_cost_model.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class PointHistoryFemaleController extends GetxController {
  static PointHistoryFemaleController get to => Get.find();
  final list = <PointCostModel>[].obs;
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _installList();
  }

  Future<void> _installList() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    loading.value = false;
  }

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }
}
