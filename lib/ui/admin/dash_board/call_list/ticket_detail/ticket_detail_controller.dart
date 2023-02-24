import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'components/select_user_dialog.dart';

class TicketDetailController extends GetxController {
  static TicketDetailController get to => Get.find();
  bool? canPop;
  dynamic id;
  final model = Rxn<Ticket>();

  @override
  void onInit() {
    super.onInit();
    canPop = Get.arguments;
    final params = Get.parameters;
    if (params['id'] != null) {
      id = params['id'];
      SchedulerBinding.instance.addPostFrameCallback((_) {
        getData();
      });
    } else {
      Get.offAllNamed(Routes.homeAdmin);
    }
  }

  Future<void> getData() async {
    loading.value = true;
    model.value = await fireStoreProvider.getTicketDetail(id: id);
  }

  void onPressedBack() {
    if (canPop == true) {
      Get.back();
    } else {
      Get.offAndToNamed(Routes.homeAdmin);
    }
  }

  void onSwitchFemaleDetail(String? id) {
    Get.toNamed(Routes.userDetail, parameters: {'id': '$id'}, arguments: true);
  }

  Future<void> cancelTicket() async {
    if (model.value == null) return;
    showConfirmDialog(
        content: 'confirm_cancel_ticket'.tr,
        onPressedConfirm: () async {
          await fireStoreProvider.cancelTicket(ticket: model.value!);
          model.value?.status = TicketStatus.cancelled.name;
          model.value?.peopleApprove.clear();
          model.refresh();
          showInfo('ticket_has_cancelled_successfully'.tr);
        });
  }

  Future<void> createTicket() async {
    if (model.value == null ||
        model.value?.peopleApprove.length != model.value?.numberPeople) return;
    showConfirmDialog(
        content: 'confirm_approve_ticket'.tr,
        onPressedConfirm: () async {
          await fireStoreProvider
              .createMessageGroupTicket(ticket: model.value!)
              .then((value) {
            model.value?.status = TicketStatus.done.name;
            model.refresh();
            showInfo('ticket_has_cancelled_successfully'.tr);
          });
        });
  }

  Future<void> onSwitchMessageDetail(String? id) async {
    final messageGroupId = generateIdMessage(['admin', id ?? '']);
    await Get.toNamed(Routes.messageDetail,
        arguments: true, parameters: {'id': messageGroupId});
  }

  Future<void> showSelectUser() async {
    showCustomDialog(
      minWidth: true,
      widget: SelectUserDialog(
        setter: (List<String?> value) {
          if (value.isNotEmpty) {
            model.value?.peopleApprove.clear();
            model.value?.peopleApprove.addAll(value);
            model.refresh();
          }
        },
        maxUser: model.value?.numberPeople,
        switchUserDetail: (String? value) {
          onSwitchFemaleDetail(value);
        },
        switchMessageDetail: (String? value) {
          onSwitchMessageDetail(value);
        },
      ),
    );
  }
}
