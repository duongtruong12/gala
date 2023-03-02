import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/sale_proceed/components/item_input.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'transfer_information_controller.dart';

class TransferInformation extends GetView<TransferInformationController> {
  const TransferInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: TransferInformationMobilePage(controller: controller),
      desktop: TransferInformationMobilePage(controller: controller),
    ));
  }
}

class TransferInformationMobilePage extends StatelessWidget {
  const TransferInformationMobilePage({super.key, required this.controller});

  final TransferInformationController controller;

  Widget _buildBody() {
    final list = <Widget>[
      Obx(() {
        return ItemInputSale(
          label: 'transfer_information'.tr,
          content: controller.bankName.value,
          onTap: () {
            controller.showInputCustom(
                label: 'transfer_information'.tr,
                type: 'bankName',
                initText: controller.bankName.value,
                validate: (String? str) {
                  return Validate.emptyValidate(
                      str: str, field: 'transfer_information'.tr);
                });
          },
        );
      }),
      const SizedBox(height: kDefaultPadding),
      Obx(() {
        return ItemInputSale(
          label: 'account_type'.tr,
          content: 'bank_${controller.bankType.value}'.tr,
          onTap: controller.showSelectLabel,
        );
      }),
      const SizedBox(height: kSmallPadding),
      Obx(() {
        return ItemInputSale(
          label: 'branch_code'.tr,
          content: controller.branchCode.value,
          onTap: () {
            controller.showInputCustom(
                label: 'branch_code'.tr,
                type: 'branchCode',
                initText: controller.branchCode.value,
                maxLength: 3,
                validate: (String? str) {
                  return Validate.emptyValidate(
                      str: str, field: 'branch_code'.tr);
                });
          },
        );
      }),
      const SizedBox(height: kSmallPadding),
      Obx(() {
        return ItemInputSale(
          label: 'account_number'.tr,
          content: controller.bankNumber.value,
          onTap: () {
            controller.showInputCustom(
                label: 'account_number'.tr,
                type: 'bankNumber',
                initText: controller.bankNumber.value,
                maxLength: 7,
                validate: (String? str) {
                  return Validate.emptyValidate(
                      str: str, field: 'account_number'.tr);
                });
          },
        );
      }),
      const SizedBox(height: kDefaultPadding),
      Obx(() {
        return ItemInputSale(
          label: 'name_say'.tr,
          content: controller.lastName.value,
          onTap: () {
            controller.showInputCustom(
                label: 'name_say'.tr,
                type: 'lastName',
                initText: controller.lastName.value,
                validate: (String? str) {
                  return Validate.emptyValidate(str: str, field: 'name_say'.tr);
                });
          },
        );
      }),
      const SizedBox(height: kSmallPadding),
      Obx(() {
        return ItemInputSale(
          label: 'name_real'.tr,
          content: controller.firstName.value,
          onTap: () {
            controller.showInputCustom(
                label: 'name_real'.tr,
                type: 'firstName',
                initText: controller.firstName.value,
                validate: (String? str) {
                  return Validate.emptyValidate(
                      str: str, field: 'name_real'.tr);
                });
          },
        );
      }),
      const SizedBox(height: kDefaultPadding),
      Text(
        'transfer_account_content'.tr,
        style:
            tNormalTextStyle.copyWith(color: kTextColorDarkLight, fontSize: 10),
      ),
      const SizedBox(height: kDefaultPadding),
      CustomButton(
          onPressed: controller.onConfirm,
          widget: Text(
            'save_card'.tr,
            style: tButtonWhiteTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w500),
          ))
    ];

    return ListView.builder(
      itemCount: list.length,
      padding: const EdgeInsets.all(kDefaultPadding),
      itemBuilder: (BuildContext context, int index) {
        return list[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          title: Text('sale_proceed'.tr),
          leadingWidth: 100,
          leading: backButtonText(callback: controller.onPressedBack)),
      body: _buildBody(),
    );
  }
}
