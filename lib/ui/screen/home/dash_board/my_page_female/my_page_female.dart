import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/my_page_female_controller.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageFemale extends GetView<MyPageFemaleController> {
  const MyPageFemale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: MyPageFemaleMobilePage(controller: controller),
      desktop: MyPageFemaleMobilePage(controller: controller),
    ));
  }
}

class MyPageFemaleMobilePage extends StatelessWidget {
  const MyPageFemaleMobilePage({super.key, required this.controller});

  final MyPageFemaleController controller;

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
    final list = [
      const SizedBox(height: kDefaultPadding),
      const SizedBox(
          height: 78,
          width: 78,
          child: CustomCircleImage(
              radius: 99,
              image: CustomNetworkImage(
                url: null,
                fit: BoxFit.fitHeight,
              ))),
      const SizedBox(height: kSmallPadding),
      Center(
        child: Text(
          'ニックネーム',
          style: tNormalTextStyle.copyWith(
              color: getTextColorSecond(),
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
      ),
      const SizedBox(height: kDefaultPadding),
      Card(
        color: kTextColorSecond,
        elevation: 3,
        child: Padding(
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
                  label: 'sale_proceed',
                  onCallBack: controller.switchPaymentInformation),
              const SizedBox(height: kDefaultPadding),
              const Divider(color: kTextColorDark, height: 1),
              const SizedBox(height: kDefaultPadding),
              _buildRecordItem(
                  label: 'user_guide', onCallBack: controller.switchUserGuide),
              const SizedBox(height: kDefaultPadding),
              const Divider(color: kTextColorDark, height: 1),
              const SizedBox(height: kDefaultPadding),
              _buildRecordItem(
                  label: 'help', onCallBack: controller.switchHelp),
              const SizedBox(height: kDefaultPadding),
            ],
          ),
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
