import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'first_time_user_controller.dart';

class FirstTimeUser extends GetView<FirstTimeUserController> {
  const FirstTimeUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: FirstTimeUserMobilePage(controller: controller),
      desktop: FirstTimeUserMobilePage(controller: controller),
    ));
  }
}

class FirstTimeUserMobilePage extends StatelessWidget {
  const FirstTimeUserMobilePage({super.key, required this.controller});

  final FirstTimeUserController controller;

  Widget _buildItemFirstTime({required String label, required String content}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: tButtonWhiteTextStyle.copyWith(
                fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: kSmallPadding),
          Text(
            content,
            style: tButtonWhiteTextStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'for_fist_time_user'.tr,
            style: tButtonWhiteTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            'for_fist_time_user_check'.tr,
            style: tButtonWhiteTextStyle.copyWith(fontSize: 10),
          ),
          const SizedBox(height: kDefaultPadding),
          _buildItemFirstTime(
              label: 'first_time_label_1'.tr,
              content: 'first_time_content_1'.tr),
          _buildItemFirstTime(
              label: 'first_time_label_2'.tr,
              content: 'first_time_content_2'.tr),
          _buildItemFirstTime(
              label: 'first_time_label_3'.tr,
              content: 'first_time_content_3'.tr),
          _buildItemFirstTime(
              label: 'first_time_label_4'.tr,
              content: 'first_time_content_4'.tr),
          const SizedBox(height: kDefaultPadding),
          CustomButton(
              onPressed: controller.switchFirstTimeUser,
              borderRadius: 4,
              widget: Text(
                'call_cast'.tr,
                style: tNormalTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          title: Text('call_cast'.tr),
          leadingWidth: 100,
          leading: backButtonText(callback: controller.onPressedBack)),
      body: _buildBody(),
    );
  }
}
