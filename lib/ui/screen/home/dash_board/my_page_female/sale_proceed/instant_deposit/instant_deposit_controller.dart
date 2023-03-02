import 'package:base_flutter/components/custom_bottom_sheet.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/model/transfer_request_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstantDepositController extends GetxController {
  static InstantDepositController get to => Get.find();
  final pointTransfer = RxNum(0);
  final totalPrice = RxNum(0);

  @override
  void onInit() {
    super.onInit();
    calculatePrice();
  }

  Future<void> showInputCurrentPoint() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInput(
            numeric: true,
            myValueSetter: (str) {
              pointTransfer.value = num.parse(str!);
              calculatePrice();
            },
            validate: Validate.pointWithdrawal,
            label: 'attendance_point'.tr,
            initText: '${pointTransfer.value}',
          );
        });
  }

  void calculatePrice() {
    totalPrice.value = pointTransfer.value + DefaultFee.transfer;
  }

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }

  Future<void> onSubmit() async {
    final model = await fireStoreProvider.getTransferInformationDetail(
        id: user.value?.id);
    if (model != null) {
      final requestModel = TransferRequestModel(
          createdDate: DateTime.now(),
          status: TransferStatus.waiting.name,
          totalPrice: totalPrice.value,
          requestPoint: pointTransfer.value,
          createdId: user.value?.id,
          transferFee: DefaultFee.transfer,
          transferInformationModel: model);
      await fireStoreProvider.setTransferRequest(model: requestModel);
      showInfo('create_withdrawal_success'.tr);
      Get.offNamedUntil(Routes.myPageFemale,
          (route) => route.settings.name == Routes.myPageFemale,
          id: getRouteMyPage());
      await Future.delayed(const Duration(milliseconds: 100));
      Get.toNamed(Routes.pointHistoryFemale, id: getRouteMyPage());
    } else {
      showConfirmDialog(
          content: 'transfer_information_missing'.tr,
          onPressedConfirm: () {
            Get.toNamed(Routes.transferInformation, id: getRouteMyPage());
          });
    }
  }
}
