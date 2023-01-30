import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/call_controller.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/select_mood/select_mood_controller.dart';
import 'package:base_flutter/ui/screen/home/home_controller.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:get/get.dart';

class ConfirmCallController extends GetxController {
  static ConfirmCallController get to => Get.find();
  final selectedSituation = <String>[].obs;
  final selectedCastType = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _installList();
  }

  Future<void> _installList() async {
    selectedSituation.addAll([
      'プライベート',
      '対話',
      '飲める人',
      'わいわい',
    ]);
    selectedCastType.addAll([
      '可愛い系',
      '綺麗系',
      '清楚系',
      'アイドル系',
    ]);
  }

  void onPressedBack() {
    Get.back(id: RouteId.call);
  }

  Future<void> onSwitchEditTag() async {
    final controller = Get.find<SelectMoodController>();
    controller.setEdit(true);
    await Get.toNamed(Routes.selectMood, id: RouteId.call, arguments: true);
    controller.setEdit(false);
  }

  Future<void> onSwitchReservation() async {
    final controller = Get.find<CallController>();
    controller.setEdit(true);
    await Get.toNamed(Routes.call, id: RouteId.call, arguments: true);
    controller.setEdit(false);
  }

  void onConfirm() {
    final controller = Get.find<HomeController>();
    controller.onTapItem(1);
  }
}
