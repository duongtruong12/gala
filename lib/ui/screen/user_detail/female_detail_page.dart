import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'female_detail_controller.dart';

class FemaleDetail extends GetView<FemaleDetailController> {
  const FemaleDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: FemaleDetailMobilePage(controller: controller),
      desktop: FemaleDetailMobilePage(controller: controller),
    ));
  }
}

class FemaleDetailMobilePage extends StatelessWidget {
  const FemaleDetailMobilePage({super.key, required this.controller});

  final FemaleDetailController controller;

  Widget _buildImageSelect() {
    if (controller.model.value?.previewImages == null ||
        controller.model.value!.previewImages!.isEmpty) {
      return Text(
        'preview_image_empty'.tr,
        style: tNormalTextStyle.copyWith(color: kTextColorSecond, fontSize: 18),
      );
    }
    final list = controller.model.value!.previewImages!;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          CustomNetworkImage(
            url: list[controller.currentSelect.value],
            height: 360,
            borderRadius: 0,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: InkWell(
                    onTap: () {
                      controller.onSwitchImage(i);
                    },
                    child: CustomNetworkImage(
                      url: list[i],
                      height: 80,
                      borderRadius: 4,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildName() {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
                style: tNormalTextStyle.copyWith(
                    color: kTextColorSecond,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
                children: [
                  TextSpan(
                      text: '${controller.model.value?.age ?? 0}${'age'.tr} '),
                  TextSpan(text: controller.model.value?.displayName ?? '')
                ]),
          ),
        ),
        Text(
          '1${'hour'.tr}/${formatCurrency(controller.model.value?.point)}',
          style: tNormalTextStyle.copyWith(
              color: kTextColorSecond,
              fontWeight: FontWeight.w500,
              fontSize: 24),
        )
      ],
    );
  }

  Widget _buildChipTag() {
    if (controller.model.value?.tags == null ||
        controller.model.value!.tags!.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: controller.model.value!.tags!
              .map((e) => Chip(label: Text(e)))
              .toList()),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'description'.tr,
          style: tNormalTextStyle.copyWith(
            color: getTextColorSecond(),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          controller.model.value?.description ?? '',
          style: tNormalTextStyle.copyWith(
            color: getTextColorSecond(),
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget _buildItemInformation(
      {required String label, required String content}) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: Text(
              label,
              style: tNormalTextStyle.copyWith(color: getTextColorSecond()),
            )),
            Text(
              content,
              style: tNormalTextStyle.copyWith(color: getTextColorSecond()),
            )
          ],
        ),
        const SizedBox(height: 16),
        const Divider()
      ],
    );
  }

  Widget _buildInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'information'.tr,
          style: tNormalTextStyle.copyWith(
            color: kTextColorSecond,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        _buildItemInformation(
            label: 'height'.tr,
            content: '${controller.model.value?.height ?? 0}cm'),
        _buildItemInformation(
            label: 'address'.tr,
            content: controller.model.value?.address ?? ''),
        _buildItemInformation(
            label: 'birth_place'.tr,
            content: controller.model.value?.birthPlace ?? ''),
        _buildItemInformation(
            label: 'education'.tr,
            content: controller.model.value?.education ?? ''),
        _buildItemInformation(
            label: 'job'.tr, content: controller.model.value?.job ?? ''),
        _buildItemInformation(
            label: 'sake'.tr,
            content: controller.model.value?.canDrink == true
                ? 'sake_can'.tr
                : 'sake_cannot'.tr),
        _buildItemInformation(
            label: 'smoke'.tr,
            content: controller.model.value?.canSmoke == true
                ? 'smoke_can'.tr
                : 'smoke_cannot'.tr),
        _buildItemInformation(
            label: 'family'.tr,
            content: controller.model.value?.siblings ?? ''),
        _buildItemInformation(
            label: 'living_family'.tr,
            content: controller.model.value?.liveFamily == true
                ? 'living_family_with'.tr
                : 'living_family_alone'.tr),
        _buildItemInformation(
            label: 'hair_style'.tr,
            content: controller.model.value?.hairStyle ?? ''),
        _buildItemInformation(
            label: 'hair_color'.tr,
            content: controller.model.value?.hairColor ?? ''),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      Obx(() {
        return _buildImageSelect();
      }),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildName(),
            _buildChipTag(),
            const SizedBox(height: 24),
            _buildDescription(),
            const SizedBox(height: 24),
            _buildInformation(),
          ],
        ),
      )
    ];
    return Background(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            padding:
                EdgeInsets.symmetric(vertical: 16, horizontal: Get.width / 4),
            child: CustomButton(
              onPressed: () async {},
              height: 43,
              width: 223,
              borderRadius: 99,
              borderColor:
                  casterAccount.value ? kTextColorDark : Colors.transparent,
              widget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    color: getColorPrimary(),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'favorite'.tr,
                    style: tButtonWhiteTextStyle.copyWith(
                        color: getColorPrimary()),
                  )
                ],
              ),
              color: kTextColorSecond,
            ),
          ),
          body: Stack(
            children: [
              ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return list[index];
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                    onTap: controller.onPressedBack,
                    child: getSvgImage('ic_back_circle')),
              ),
            ],
          )),
    );
  }
}
