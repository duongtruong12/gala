import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/components/paging_grid.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/search/components/item_target.dart';
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
      mobile: SearchDetailMobilePage(controller: controller),
      desktop: SearchDetailMobilePage(controller: controller),
    ));
  }
}

class SearchDetailMobilePage extends StatelessWidget {
  const SearchDetailMobilePage({super.key, required this.controller});

  final SearchDetailController controller;

  Widget _buildItemInformation({
    required String label,
    required String? content,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: kDefaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              label,
              style: tNormalTextStyle.copyWith(color: getTextColorSecond()),
            )),
            Text(
              content ?? 'not_entered'.tr,
              style: tNormalTextStyle.copyWith(
                  color: getTextColorSecond(),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            getSvgImage('ic_arrow_down', color: getColorPrimary())
          ],
        ),
      ),
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
      Obx(() {
        return _buildItemInformation(
            label: 'address'.tr,
            content: controller.address.value,
            onPressed: () {
              controller.selectCity(
                  type: 'address',
                  label: 'address'.tr,
                  initText: controller.address.value);
            });
      }),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 16),
      Obx(() {
        return _buildItemInformation(
            label: 'birth_place'.tr,
            content: controller.birthPlace.value,
            onPressed: () {
              controller.selectCity(
                  type: 'birthPlace',
                  label: 'birth_place'.tr,
                  initText: controller.birthPlace.value);
            });
      }),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 16),
      Obx(() {
        return _buildItemInformation(
          label: 'age_drop_down'.tr,
          content: controller.listAge.length > 1
              ? '${controller.listAge[0]}${'age'.tr}~${controller.listAge[1]}${'age'.tr}'
              : null,
          onPressed: () {
            controller.showSelectRange(
              type: 'age',
              label: 'age_drop_down'.tr,
              minValue:
                  controller.listAge.length > 1 ? controller.listAge[0] : null,
              maxValue:
                  controller.listAge.length > 1 ? controller.listAge[1] : null,
              requiredMinValue: 20,
              requiredMaxValue: 35,
              behindText: 'age'.tr,
            );
          },
        );
      }),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 16),
      Obx(() {
        return _buildItemInformation(
          label: 'height'.tr,
          content: controller.listHeight.length > 1
              ? '${controller.listHeight[0]}cm~${controller.listHeight[1]}cm'
              : null,
          onPressed: () {
            controller.showSelectRange(
              type: 'height',
              label: 'height'.tr,
              minValue: controller.listHeight.length > 1
                  ? controller.listHeight[0]
                  : null,
              maxValue: controller.listHeight.length > 1
                  ? controller.listHeight[1]
                  : null,
              requiredMinValue: 130,
              requiredMaxValue: 200,
              behindText: 'cm',
            );
          },
        );
      }),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 24),
      CustomButton(
        onPressed: () async {
          controller.onRefresh(1);
        },
        widget: Text(
          'search_condition'.tr,
          style: tNormalTextStyle.copyWith(color: getTextColorButton()),
        ),
      )
    ];

    return Obx(() {
      if (controller.searchState.value) {
        if (controller.list.isEmpty) {
          return textEmpty();
        }
        return Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: PagingGridCustom(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              onScrollDown: controller.onScrollDown,
              onRefresh: controller.onRefresh,
              childWidget: controller.list
                  .map((element) => ItemTarget(
                        model: element,
                        femaleGender: casterAccount.value,
                        onPressed: () {
                          controller.onSwitchUserDetail(element.id);
                        },
                      ))
                  .toList()),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('search'.tr),
        leading: InkWell(
          onTap: controller.onPressedBack,
          child: const Icon(
            Icons.close_rounded,
            size: 24,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }
}
