import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/sale_proceed/components/item_input.dart';
import 'package:base_flutter/utils/const.dart';
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
      ItemInputSale(
        label: 'transfer_information'.tr,
        content: '銀行名',
      ),
      const SizedBox(height: kDefaultPadding),
      ItemInputSale(
        label: 'account_type'.tr,
        content: '普通',
      ),
      const SizedBox(height: kSmallPadding),
      ItemInputSale(
        label: 'branch_code'.tr,
        content: '123',
      ),
      const SizedBox(height: kSmallPadding),
      ItemInputSale(
        label: 'account_number'.tr,
        content: '1234567',
      ),
      const SizedBox(height: kDefaultPadding),
      ItemInputSale(
        label: 'name_say'.tr,
        content: 'Name',
      ),
      const SizedBox(height: kSmallPadding),
      ItemInputSale(
        label: 'name_real'.tr,
        content: 'Name',
      ),
      const SizedBox(height: kDefaultPadding),
      Text(
        'transfer_account_content'.tr,
        style:
            tNormalTextStyle.copyWith(color: kTextColorDarkLight, fontSize: 10),
      ),
      const SizedBox(height: kDefaultPadding),
      CustomButton(
          onPressed: () async {
            controller.onPressedBack();
          },
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
