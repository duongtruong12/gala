import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_detail_controller.dart';

class SearchDetail extends GetView<SearchDetailController> {
  const SearchDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: SearchDetailMobilePage(
          controller: controller, femaleGender: casterAccount.value),
      desktop: SearchDetailMobilePage(
          controller: controller, femaleGender: casterAccount.value),
    ));
  }
}

class SearchDetailMobilePage extends StatelessWidget {
  const SearchDetailMobilePage(
      {super.key, required this.controller, this.femaleGender = false});

  final SearchDetailController controller;
  final bool femaleGender;

  Widget _buildSelectSearch(String search) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            search.tr,
            style: tNormalTextStyle.copyWith(
                fontWeight: FontWeight.w500, color: getTextColorSecond()),
          ),
        ),
        Row(
          children: [
            Text(
              'unselected'.tr,
              style: tNormalTextStyle.copyWith(color: getColorPrimary()),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded, color: getColorPrimary())
          ],
        )
      ],
    );
  }

  Widget _buildBody() {
    final list = [
      Text(
        'search_basic'.tr,
        style: tNormalTextStyle.copyWith(
          color: getColorPrimary(),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 16),
      _buildSelectSearch('address'.tr),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 16),
      _buildSelectSearch('birth_place'.tr),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 16),
      _buildSelectSearch('age_drop_down'.tr),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 16),
      _buildSelectSearch('height'.tr),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 24),
      Text(
        'tag'.tr,
        style: tNormalTextStyle.copyWith(
          color: getColorPrimary(),
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'tag_content'.tr,
        style: tNormalTextStyle.copyWith(color: getTextColorSecond()),
      ),
      const SizedBox(height: 32),
      CustomButton(
        onPressed: () async {
          Get.back(id: getRouteSearch());
        },
        widget: Text(
          'search_condition'.tr,
          style: tNormalTextStyle.copyWith(color: getTextColorButton()),
        ),
      )
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
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
        title: Text('search'.tr),
        leading: InkWell(
          onTap: () {
            Get.back(id: getRouteSearch());
          },
          child: const Icon(
            Icons.close_rounded,
            size: 24,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'save'.tr,
                style: tNormalTextStyle.copyWith(
                    fontSize: 12,
                    color: femaleGender ? kTextColorSecond : kTextColorPrimary),
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
}
