import 'package:base_flutter/components/custom_bottom_sheet.dart';
import 'package:base_flutter/model/transfer_information_model.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

enum BankType { usually, current }

class TransferInformationController extends GetxController {
  static TransferInformationController get to => Get.find();
  final bankType = BankType.usually.name.obs;
  final bankName = Rxn<String>();
  final branchCode = Rxn<String>();
  final bankNumber = Rxn<String>();
  final lastName = Rxn<String>();
  final firstName = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  Future<void> getData() async {
    final model = await fireStoreProvider.getTransferInformationDetail(
        id: user.value?.id);
    if (model != null) {
      bankName.value = model.bankName;
      branchCode.value = model.branchCode;
      bankNumber.value = model.bankNumber;
      lastName.value = model.lastName;
      firstName.value = model.firstName;
      bankType.value = BankType.values
          .firstWhere((element) => element.name == model.bankType)
          .name;
    }
  }

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }

  Future<void> showSelectLabel() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomSelectDropdown(
            myValueSetter: (value) async {
              bankType.value = value;
            },
            label: 'account_type'.tr,
            init: bankType.value,
            map: {
              'bank_usually'.tr: BankType.usually.name,
              'bank_current'.tr: BankType.current.name,
            },
          );
        });
  }

  Future<void> showInputCustom({
    required String label,
    required String type,
    required String? initText,
    int? maxLength,
    required String? Function(String? str)? validate,
  }) async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInput(
            maxLength: maxLength,
            myValueSetter: (str) {
              if (type == 'bankName') {
                bankName.value = str;
              } else if (type == 'branchCode') {
                branchCode.value = str;
              } else if (type == 'lastName') {
                lastName.value = str;
              } else if (type == 'firstName') {
                firstName.value = str;
              } else {
                bankNumber.value = str;
              }
            },
            validate: validate,
            label: label,
            initText: initText,
          );
        });
  }

  Future<void> onConfirm() async {
    if (bankName.value != null &&
        branchCode.value != null &&
        bankNumber.value != null &&
        lastName.value != null &&
        firstName.value != null) {
      final model = TransferInformationModel(
        id: user.value?.id,
        bankName: bankName.value,
        branchCode: branchCode.value,
        bankNumber: bankNumber.value,
        lastName: lastName.value,
        firstName: firstName.value,
        bankType: bankType.value,
      );
      await fireStoreProvider
          .setTransferInformation(model: model)
          .then((value) {
        onPressedBack();
        showInfo('save_transfer_success'.tr);
      });
    } else {
      showError('fill_above_field'.tr);
    }
  }
}
