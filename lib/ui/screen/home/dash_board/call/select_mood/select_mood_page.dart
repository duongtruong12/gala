import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/components/select_tag.dart';
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

  Widget _buildBody() {
    final list = [
      Text(
        'today_mood'.tr,
        style: tButtonWhiteTextStyle.copyWith(fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: kDefaultPadding),
      SelectTag(
        initList: controller.ticket.value.tagInformation,
        valueSetter: controller.switchFirstTimeUser,
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
        title: Text('call_cast'.tr),
        leadingWidth: 100,
        leading: backButtonText(callback: controller.onPressedBack),
      ),
      body: _buildBody(),
    );
  }
}
