import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/call_controller.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class SelectMoodController extends GetxController {
  static SelectMoodController get to => Get.find();
  final edit = Rxn<bool>();
  final ticket =
      Ticket(peopleApply: [], tagInformation: [], peopleApprove: []).obs;

  @override
  void onInit() {
    super.onInit();
    getTicket();
  }

  void getTicket() {
    final controller = Get.find<CallController>();
    ticket.value = controller.getTicket();
  }

  void setTicker() {
    final controller = Get.find<CallController>();
    controller.setTicket(ticket.value);
  }

  void onPressedBack() {
    Get.back(id: RouteId.call);
  }

  Future<void> switchFirstTimeUser(List selectedList) async {
    if (selectedList.isEmpty) {
      showError('error_select_fields'.tr);
      return;
    }
    ticket.value.tagInformation.clear();
    ticket.value.tagInformation.addAll(selectedList);
    setTicker();
    if (edit.value == true) {
      onPressedBack();
    } else {
      Get.toNamed(Routes.firstTimeUser, id: RouteId.call);
    }
  }

  void setEdit(bool edit) {
    this.edit.value = edit;
  }
}
