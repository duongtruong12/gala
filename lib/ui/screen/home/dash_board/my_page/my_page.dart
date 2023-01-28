import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_page_controller.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: MyPageMobilePage(controller: controller),
      desktop: MyPageMobilePage(controller: controller),
    ));
  }
}

class MyPageMobilePage extends StatelessWidget {
  const MyPageMobilePage({super.key, required this.controller});

  final MyPageController controller;

  Widget _buildRecordItem(
      {required String label, required VoidCallback onCallBack}) {
    return InkWell(
      onTap: onCallBack,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          getSvgImage('ic_$label'),
          const SizedBox(width: kDefaultPadding),
          Expanded(child: Text(label.tr, style: tNormalTextStyle)),
          const SizedBox(width: kDefaultPadding),
          getSvgImage('ic_arrow_right')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          title: Text('my_page'.tr), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(kDefaultPadding),
        child: Column(
          children: [
            const SizedBox(height: kDefaultPadding),
            const CustomCircleImage(
                radius: 99, image: CustomNetworkImage(url: null)),
            const SizedBox(height: kSmallPadding),
            Text(
              'ニックネーム',
              style: tNormalTextStyle.copyWith(
                  color: kTextColorSecond,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              formatCurrency(10000),
              style: tNormalTextStyle.copyWith(color: kTextColorPrimary),
            ),
            const SizedBox(height: kDefaultPadding),
            Container(
              color: kTextColorSecond,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  const SizedBox(height: kDefaultPadding),
                  _buildRecordItem(
                      label: 'edit_profile',
                      onCallBack: controller.switchEditProfile),
                  const SizedBox(height: kDefaultPadding),
                  const Divider(color: kTextColorDark, height: 1),
                  const SizedBox(height: kDefaultPadding),
                  _buildRecordItem(label: 'point_history', onCallBack: () {}),
                  const SizedBox(height: kDefaultPadding),
                  const Divider(color: kTextColorDark, height: 1),
                  const SizedBox(height: kDefaultPadding),
                  _buildRecordItem(
                      label: 'payment_information', onCallBack: () {}),
                  const SizedBox(height: kDefaultPadding),
                  const Divider(color: kTextColorDark, height: 1),
                  const SizedBox(height: kDefaultPadding),
                  _buildRecordItem(label: 'user_guide', onCallBack: () {}),
                  const SizedBox(height: kDefaultPadding),
                  const Divider(color: kTextColorDark, height: 1),
                  const SizedBox(height: kDefaultPadding),
                  _buildRecordItem(label: 'help', onCallBack: () {}),
                  const SizedBox(height: kDefaultPadding),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
