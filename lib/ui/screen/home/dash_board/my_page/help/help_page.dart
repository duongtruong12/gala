import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'help_controller.dart';

class HelpPage extends GetView<HelpPageController> {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: HelpPageMobilePage(controller: controller),
      desktop: HelpPageMobilePage(controller: controller),
    ));
  }
}

class HelpPageMobilePage extends StatelessWidget {
  const HelpPageMobilePage({super.key, required this.controller});

  final HelpPageController controller;

  Widget buildItemLaw({required label}) {
    return Column(
      children: [
        const SizedBox(height: kSmallPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              label,
              style: tNormalTextStyle.copyWith(color: kTextColorSecond),
            )),
            getSvgImage('ic_arrow_right', color: kPrimaryColor)
          ],
        ),
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
          buildItemLaw(label: 'term_service'.tr),
          buildItemLaw(label: 'privacy_policy'.tr),
          buildItemLaw(label: 'law'.tr),
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
