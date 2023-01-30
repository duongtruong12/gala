import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'help_female_controller.dart';

class HelpFemale extends GetView<HelpFemaleController> {
  const HelpFemale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: HelpFemaleMobilePage(controller: controller),
      desktop: HelpFemaleMobilePage(controller: controller),
    ));
  }
}

class HelpFemaleMobilePage extends StatelessWidget {
  const HelpFemaleMobilePage({super.key, required this.controller});

  final HelpFemaleController controller;

  Widget _buildItem({required String label, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  label,
                  style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w500),
                )),
                getSvgImage('ic_arrow_right', color: kPrimaryColorFemale),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          _buildItem(label: 'faq'.tr, onPressed: controller.switchFaq),
          _buildItem(label: 'term_service'.tr, onPressed: () {}),
          _buildItem(label: 'privacy_policy'.tr, onPressed: () {}),
          _buildItem(label: 'law'.tr, onPressed: () {}),
        ],
      ),
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
