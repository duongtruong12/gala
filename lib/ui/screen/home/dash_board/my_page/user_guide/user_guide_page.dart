import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/components/paging_list.dart';
import 'package:base_flutter/model/faq_model.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_guide_controller.dart';

class UserGuide extends GetView<UserGuideController> {
  const UserGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: UserGuideMobilePage(controller: controller),
      desktop: UserGuideMobilePage(controller: controller),
    ));
  }
}

class UserGuideMobilePage extends StatelessWidget {
  const UserGuideMobilePage({super.key, required this.controller});

  final UserGuideController controller;

  Widget _buildItemFaq(FaqModel model) {
    Widget _buildFaq({required String icon, required String? content}) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            getSvgImage(icon),
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Text(
                content ?? '',
                style: tNormalTextStyle.copyWith(
                    color: kTextColorSecond, fontSize: 16),
              ),
            )
          ]);
    }

    return Column(
      children: [
        const SizedBox(height: kDefaultPadding),
        _buildFaq(icon: 'ic_q', content: model.question),
        const SizedBox(height: kDefaultPadding),
        _buildFaq(icon: 'ic_a', content: model.answer),
        const SizedBox(height: kSmallPadding),
        const Divider(),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomButton(
            onPressed: () async {},
            height: 60,
            widget: Text(
              'faq'.tr,
              style:
                  tNormalTextStyle.copyWith(color: kPrimaryColor, fontSize: 18),
            ),
            borderColor: kPrimaryColor,
            color: Colors.transparent,
          ),
          Expanded(
              child: PagingListCustom(
            childWidget: controller.list.map((e) => _buildItemFaq(e)).toList(),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('user_guide'.tr),
        leadingWidth: 100,
        leading: backButtonText(callback: controller.onPressedBack),
      ),
      body: _buildBody(),
    );
  }
}
