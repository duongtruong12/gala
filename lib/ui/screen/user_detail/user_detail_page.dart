import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_detail_controller.dart';

class UserDetail extends GetView<UserDetailController> {
  const UserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: UserDetailMobilePage(controller: controller),
      desktop: UserDetailMobilePage(controller: controller),
    ));
  }
}

class UserDetailMobilePage extends StatelessWidget {
  const UserDetailMobilePage({super.key, required this.controller});

  final UserDetailController controller;

  Widget _buildImageSelect() {
    if (controller.model.value?.previewImage == null ||
        controller.model.value!.previewImage.isEmpty) {
      return Text(
        'preview_image_empty'.tr,
        style: tNormalTextStyle.copyWith(color: kTextColorSecond, fontSize: 18),
      );
    }
    final list = controller.model.value!.previewImage;

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
                      width: 150,
                      fit: BoxFit.fitWidth,
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
                      text:
                          controller.model.value?.getAge() ?? 'not_entered'.tr),
                  TextSpan(
                      text: controller.model.value?.displayName ??
                          'not_entered'.tr)
                ]),
          ),
        ),
        Text(
          formatCurrency(controller.model.value?.pointPer30Minutes,
              symbol: CurrencySymbol.pointPerMinutes),
          style: tNormalTextStyle.copyWith(
              color: kTextColorSecond,
              fontWeight: FontWeight.w500,
              fontSize: 24),
        )
      ],
    );
  }

  Widget _buildChipTag() {
    if (controller.model.value?.tagInformation == null ||
        controller.model.value!.tagInformation.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: controller.model.value!.tagInformation
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
          controller.model.value?.description ?? 'not_entered'.tr,
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
            content: controller.model.value?.address ?? 'not_entered'.tr),
        _buildItemInformation(
            label: 'birth_place'.tr,
            content: controller.model.value?.birthPlace ?? 'not_entered'.tr),
        _buildItemInformation(
            label: 'education'.tr,
            content: controller.model.value?.education ?? 'not_entered'.tr),
        _buildItemInformation(
            label: 'job'.tr,
            content: controller.model.value?.job ?? 'not_entered'.tr),
        _buildItemInformation(
            label: 'sake'.tr,
            content:
                controller.model.value?.getTextDrink() ?? 'not_entered'.tr),
        _buildItemInformation(
            label: 'smoke'.tr,
            content:
                controller.model.value?.getTextSmoke() ?? 'not_entered'.tr),
        _buildItemInformation(
            label: 'family'.tr,
            content: controller.model.value?.familyStatus ?? 'not_entered'.tr),
        _buildItemInformation(
            label: 'living_family'.tr,
            content: controller.model.value?.getTextLiveFamily() ??
                'not_entered'.tr),
        _buildItemInformation(
            label: 'hair_style'.tr,
            content: controller.model.value?.hairStyle ?? 'not_entered'.tr),
        _buildItemInformation(
            label: 'hair_color'.tr,
            content: controller.model.value?.hairColor ?? 'not_entered'.tr),
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
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildName(),
              _buildChipTag(),
              const SizedBox(height: 24),
              _buildDescription(),
              const SizedBox(height: 24),
              _buildInformation(),
            ],
          );
        }),
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
          body: Obx(() {
            if (controller.model.value == null) {
              return const Center(
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Stack(
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
            );
          })),
    );
  }
}
