import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/sale_proceed/components/item_input.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'instant_deposit_controller.dart';

class InstantDeposit extends GetView<InstantDepositController> {
  const InstantDeposit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: InstantDepositMobilePage(controller: controller),
      desktop: InstantDepositMobilePage(controller: controller),
    ));
  }
}

class InstantDepositMobilePage extends StatelessWidget {
  const InstantDepositMobilePage({super.key, required this.controller});

  final InstantDepositController controller;

  Widget _buildBody() {
    final list = <Widget>[
      ItemInputSale(label: 'attendance_point'.tr, content: formatCurrency(0)),
      const SizedBox(height: kSmallPadding),
      ItemInputSale(label: 'commission'.tr, content: '- 円'),
      const SizedBox(height: kSmallPadding),
      ItemInputSale(label: 'transfer_amount_money'.tr, content: '- 円'),
      Text(
        'instant_deposit_content'.tr,
        style:
            tNormalTextStyle.copyWith(fontSize: 10, color: kTextColorDarkLight),
      ),
      const SizedBox(height: kDefaultPadding),
      Text(
        'please_select'.tr,
        style:
            tNormalTextStyle.copyWith(fontSize: 12, color: kTextColorDarkLight),
      ),
      const SizedBox(height: kSmallPadding),
      Text(
        'instant_deposit_short'.tr,
        style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w500),
      ),
      const Divider(),
      const SizedBox(height: kSmallPadding),
      Text(
        'normal_deposit'.tr,
        style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w500),
      ),
      const Divider(),
      const SizedBox(height: kDefaultPadding),
      Text(
        'instant_deposit_content_1'.tr,
        style:
            tNormalTextStyle.copyWith(fontSize: 10, color: kTextColorDarkLight),
      ),
      const SizedBox(height: kDefaultPadding),
      CustomButton(
          onPressed: () async {},
          widget: Text(
            'apply'.tr,
            style: tButtonWhiteTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w500),
          )),
      const SizedBox(height: kDefaultPadding),
      Text(
        'instant_deposit_content_2'.tr,
        style:
            tNormalTextStyle.copyWith(fontSize: 10, color: kTextColorDarkLight),
      ),
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