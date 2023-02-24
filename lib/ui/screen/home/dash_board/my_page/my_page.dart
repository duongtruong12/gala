import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
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
      {required String label,
      required VoidCallback onCallBack,
      bool logout = false}) {
    return InkWell(
      onTap: onCallBack,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          logout
              ? const Icon(
                  Icons.logout,
                  color: kPurchaseColor,
                )
              : getSvgImage('ic_$label'),
          SizedBox(width: logout ? kSmallPadding : kDefaultPadding),
          Expanded(
              child: Text(label.tr,
                  style: tNormalTextStyle.copyWith(
                      color: logout ? kErrorColor : kTextColorDark))),
          const SizedBox(width: kDefaultPadding),
          getSvgImage('ic_arrow_right')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      const SizedBox(height: kDefaultPadding),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 78,
              width: 78,
              child: CustomCircleImage(
                  radius: 99,
                  image: Obx(() {
                    return CustomNetworkImage(
                      url: user.value?.avatar,
                      fit: BoxFit.fitHeight,
                      height: 78,
                      width: 78,
                    );
                  }))),
        ],
      ),
      const SizedBox(height: kSmallPadding),
      Center(
        child: Text(
          'ニックネーム',
          style: tNormalTextStyle.copyWith(
              color: kTextColorSecond,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
      ),
      const SizedBox(height: 4),
      Center(
        child: Text(
          formatCurrency(user.value?.currentPoint),
          style: tNormalTextStyle.copyWith(color: kTextColorPrimary),
        ),
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
            _buildRecordItem(
                label: 'point_history',
                onCallBack: controller.switchPointHistory),
            const SizedBox(height: kDefaultPadding),
            const Divider(color: kTextColorDark, height: 1),
            const SizedBox(height: kDefaultPadding),
            _buildRecordItem(
                label: 'user_guide', onCallBack: controller.switchUserGuide),
            const SizedBox(height: kDefaultPadding),
            const Divider(color: kTextColorDark, height: 1),
            const SizedBox(height: kDefaultPadding),
            _buildRecordItem(label: 'help', onCallBack: controller.switchHelp),
            const SizedBox(height: kDefaultPadding),
            const Divider(color: kTextColorDark, height: 1),
            const SizedBox(height: kDefaultPadding),
            _buildRecordItem(label: 'logout', onCallBack: logout, logout: true),
            const SizedBox(height: kDefaultPadding),
          ],
        ),
      )
    ];
    return Scaffold(
      appBar: appbarCustom(
          title: Text('my_page'.tr), automaticallyImplyLeading: false),
      body: ListView.builder(
        padding: const EdgeInsetsDirectional.all(kDefaultPadding),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
      ),
    );
  }
}
