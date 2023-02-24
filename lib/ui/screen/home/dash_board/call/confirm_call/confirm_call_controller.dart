import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/call_controller.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/select_mood/select_mood_controller.dart';
import 'package:base_flutter/ui/screen/home/home_controller.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:get/get.dart';

class ConfirmCallController extends GetxController {
  static ConfirmCallController get to => Get.find();
  final ticket =
      Ticket(peopleApply: [], tagInformation: [], peopleApprove: []).obs;

  @override
  void onInit() {
    super.onInit();
    getTicket();
  }

  Future<void> getTicket() async {
    final controller = Get.find<CallController>();
    ticket.value = controller.getTicket();
    ticket.refresh();
  }

  void onPressedBack() {
    Get.back(id: RouteId.call);
  }

  Future<void> onSwitchEditTag() async {
    final controller = Get.find<SelectMoodController>();
    controller.setEdit(true);
    await Get.toNamed(Routes.selectMood, id: RouteId.call, arguments: true);
    controller.setEdit(false);
    getTicket();
  }

  Future<void> onSwitchReservation() async {
    final controller = Get.find<CallController>();
    controller.setEdit(true);
    await Get.toNamed(Routes.call, id: RouteId.call, arguments: true);
    controller.setEdit(false);
    getTicket();
  }

  Future<void> onConfirm() async {
    if (ticket.value.calculateTotalPrice() > (user.value?.currentPoint ?? 0)) {
      showConfirmDialog(
          content: 'not_enough_point'.tr,
          onPressedConfirm: () {
            Get.toNamed(Routes.purchasePoint, id: RouteId.call);
          });
      return;
    }
    await fireStoreProvider
        .createTicket(ticket: ticket.value)
        .then((value) async {
      showInfo('created_ticket_successfully'.tr);
      final controller = Get.find<CallController>();
      controller.setTicket(
          Ticket(peopleApply: [], tagInformation: [], peopleApprove: []));
      Get.offNamedUntil(
          Routes.call, (route) => route.settings.name == Routes.call,
          id: RouteId.call);
      await Future.delayed(const Duration(milliseconds: 100));
      final homeController = Get.find<HomeController>();
      homeController.onTapItem(1);
    });
  }
}
