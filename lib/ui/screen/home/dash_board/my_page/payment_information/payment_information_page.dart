import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/credit_card_detector.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payment_information_controller.dart';

class PaymentInformation extends GetView<PaymentInformationController> {
  const PaymentInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: PaymentInformationMobilePage(controller: controller),
      desktop: PaymentInformationMobilePage(controller: controller),
    ));
  }
}

class PaymentInformationMobilePage extends StatelessWidget {
  const PaymentInformationMobilePage({super.key, required this.controller});

  final PaymentInformationController controller;

  Widget _buildBody() {
    final list = [
      const SizedBox(height: kDefaultPadding),
      Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding * 2, horizontal: kDefaultPadding),
        child: Column(
          children: [
            Obx(() {
              return controller.model.value == null
                  ? Text(
                      'payment_empty'.tr,
                      style:
                          tNormalTextStyle.copyWith(color: kTextColorDarkLight),
                    )
                  : Text(
                      '${detectCCType(controller.model.value?.cardNumber ?? '').name.toUpperCase()} ${obscureText(controller.model.value?.cardNumber ?? '')}',
                      style:
                          tNormalTextStyle.copyWith(color: kTextColorDarkLight),
                    );
            }),
            const SizedBox(height: kDefaultPadding),
            CustomButton(
                onPressed: controller.showAddPaymentDialog,
                color: Colors.transparent,
                borderColor: kPurchaseColor,
                borderRadius: kSmallPadding,
                width: 185,
                height: 35,
                widget: Text(
                  'add_payment'.tr,
                  style: tNormalTextStyle.copyWith(color: kPurchaseColor),
                )),
          ],
        ),
      ),
      const SizedBox(height: kDefaultPadding),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding * 2, horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'payment_register_content'.tr,
              style: tNormalTextStyle.copyWith(color: kTextColorDarkLight),
            ),
            const SizedBox(height: kSmallPadding),
            getPngImage('payment_available', height: 32, width: 250),
            const SizedBox(height: kSmallPadding),
            Text(
              'payment_register_content_1'.tr,
              style: tNormalTextStyle.copyWith(color: kTextColorDarkLight),
            ),
          ],
        ),
      )
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(kDefaultPadding),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return list[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('payment_information'.tr),
        leadingWidth: 100,
        leading: backButtonText(callback: () {
          Get.back(id: getRouteMyPage());
        }),
      ),
      body: _buildBody(),
    );
  }
}
