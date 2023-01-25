import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_detail_controller.dart';

class SearchDetail extends GetView<SearchDetailController> {
  const SearchDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: SearchDetailMobilePage(controller: controller),
      desktop: SearchDetailMobilePage(controller: controller),
    ));
  }
}

class SearchDetailMobilePage extends StatelessWidget {
  const SearchDetailMobilePage({super.key, required this.controller});

  final SearchDetailController controller;

  Widget _buildSelectSearch(String search) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            search.tr,
            style: tNormalTextStyle.copyWith(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Row(
          children: [
            Text(
              'not_select'.tr,
              style: tNormalTextStyle.copyWith(color: kTextColorPrimary),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded, color: kPrimaryColor)
          ],
        )
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'search_basic'.tr,
            style: tNormalTextStyle.copyWith(
              color: kTextColorPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSelectSearch('address'.tr),
          const SizedBox(height: 16),
          const Divider(color: Colors.white, height: 1),
          const SizedBox(height: 16),
          _buildSelectSearch('birth_place'.tr),
          const SizedBox(height: 16),
          const Divider(color: Colors.white, height: 1),
          const SizedBox(height: 16),
          _buildSelectSearch('age_drop_down'.tr),
          const SizedBox(height: 16),
          const Divider(color: Colors.white, height: 1),
          const SizedBox(height: 16),
          _buildSelectSearch('height'.tr),
          const SizedBox(height: 16),
          const Divider(color: Colors.white, height: 1),
          const SizedBox(height: 24),
          Text(
            'tag'.tr,
            style: tNormalTextStyle.copyWith(
              color: kTextColorPrimary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'tag_content'.tr,
            style: tNormalTextStyle.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 32),
          CustomButton(
            onPressed: () async {},
            widget: Text(
              'search_condition'.tr,
              style: tNormalTextStyle,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('search'.tr),
        leading: InkWell(
          onTap: () {
            Get.back(id: RouteId.search);
          },
          child: const Icon(
            Icons.close_rounded,
            color: kPrimaryColor,
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
                    fontSize: 12, color: kTextColorPrimary),
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
}
