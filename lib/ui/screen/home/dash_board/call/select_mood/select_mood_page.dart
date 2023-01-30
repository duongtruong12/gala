import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/components/chip_item_select.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'select_mood_controller.dart';

class SelectMood extends GetView<SelectMoodController> {
  const SelectMood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: SelectMoodMobilePage(controller: controller),
      desktop: SelectMoodMobilePage(controller: controller),
    ));
  }
}

class SelectMoodMobilePage extends StatelessWidget {
  const SelectMoodMobilePage({super.key, required this.controller});

  final SelectMoodController controller;

  Widget _buildWrapSituation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Obx(() {
        return Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: controller.listSituation
                .map((e) => ChipItemSelect(
                      text: e,
                      isSelect: controller.selectedSituation.contains(e),
                      onPress: controller.onSelectSituation,
                    ))
                .toList());
      }),
    );
  }

  Widget _buildWrapCastType() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Obx(() {
        return Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: controller.listCastType
                .map((e) => ChipItemSelect(
                      text: e,
                      isSelect: controller.selectedCastType.contains(e),
                      onPress: controller.onSelectCastType,
                    ))
                .toList());
      }),
    );
  }

  Widget _buildBody() {
    final list = [
      Text(
        'today_mood'.tr,
        style: tButtonWhiteTextStyle.copyWith(fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: kDefaultPadding),
      Text(
        'situation'.tr,
        style: tButtonWhiteTextStyle.copyWith(
            fontSize: 14, fontWeight: FontWeight.w500),
      ),
      _buildWrapSituation(),
      const SizedBox(height: kDefaultPadding),
      Text(
        'cast_type'.tr,
        style: tButtonWhiteTextStyle.copyWith(
            fontSize: 14, fontWeight: FontWeight.w500),
      ),
      _buildWrapCastType(),
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
        title: Text('call_cast'.tr),
        leadingWidth: 100,
        leading: backButtonText(callback: controller.onPressedBack),
      ),
      body: _buildBody(),
    );
  }
}
