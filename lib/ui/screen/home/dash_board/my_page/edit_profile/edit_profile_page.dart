import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_profile_controller.dart';

class EditProfile extends GetView<EditProfileController> {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: EditProfileMobilePage(controller: controller),
      desktop: EditProfileMobilePage(controller: controller),
    ));
  }
}

class EditProfileMobilePage extends StatelessWidget {
  const EditProfileMobilePage({super.key, required this.controller});

  final EditProfileController controller;

  Widget _buildItemInformation({
    required String label,
    required String content,
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
              content,
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

  Widget buildFieldInput({
    required String label,
    required String? content,
    Widget? widgetContent,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: tNormalTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: getTextColorSecond()),
          ),
          const SizedBox(height: kDefaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: widgetContent ??
                      Text(
                        content ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        style: tNormalTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: getTextColorSecond()),
                      )),
              getSvgImage('ic_arrow_down', color: getColorPrimary())
            ],
          )
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(onTap: controller.swapImage, child: getSvgImage('ic_swap')),
        const SizedBox(width: kDefaultPadding),
        Expanded(
            child: SizedBox(
          height: 44,
          child: Obx(() {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.listImage.length,
              itemBuilder: (BuildContext context, int index) {
                final e = controller.listImage[index];
                return Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: CustomCircleImage(
                    radius: 99,
                    image: CustomNetworkImage(
                      url: e,
                      fit: BoxFit.cover,
                      height: 44,
                      width: 44,
                    ),
                  ),
                );
              },
            );
          }),
        )),
        InkWell(
          onTap: controller.selectImage,
          child: getSvgImage('ic_add_photo'),
        )
      ],
    );
  }

  Widget _hideAge() {
    return Row(
      children: [
        Expanded(
            child: Text(
          'hide_your_age'.tr,
          style: tNormalTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: getTextColorSecond()),
        )),
        Obx(() {
          return Switch(
              value: user.value?.hideAge ?? false,
              onChanged: controller.switchHideAge);
        })
      ],
    );
  }

  Widget _buildInformation() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kDefaultPadding),
          Text(
            'information'.tr,
            style: tNormalTextStyle.copyWith(
                color: getTextColorSecond(), fontSize: 16),
          ),
          _buildItemInformation(
              label: 'height'.tr,
              content: '${user.value?.height ?? 'unselected'.tr}',
              onPressed: () {
                controller.showInput(
                  type: 'height',
                  label: 'height'.tr,
                  initText: '${user.value?.height ?? 0}',
                  numeric: true,
                );
              }),
          const Divider(),
          _buildItemInformation(
              label: 'address'.tr,
              content: user.value?.address ?? 'not_entered'.tr,
              onPressed: () {
                controller.showInput(
                    type: 'address',
                    label: 'address'.tr,
                    initText: user.value?.address);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'birth_place'.tr,
              content: user.value?.birthPlace ?? 'not_entered'.tr,
              onPressed: () {
                controller.showInput(
                    type: 'birthPlace',
                    label: 'birth_place'.tr,
                    initText: user.value?.birthPlace);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'education'.tr,
              content: user.value?.education ?? 'not_entered'.tr,
              onPressed: () {
                controller.showInput(
                    type: 'education',
                    label: 'education'.tr,
                    initText: user.value?.education);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'annual_income'.tr,
              content: user.value?.annualIncome != null
                  ? formatCurrency(user.value?.annualIncome,
                      symbol: CurrencySymbol.japan)
                  : 'not_entered'.tr,
              onPressed: () {
                controller.showInput(
                    type: 'annualIncome',
                    label: 'annual_income'.tr,
                    numeric: true,
                    initText: '${user.value?.annualIncome ?? 0}');
              }),
          const Divider(),
          _buildItemInformation(
              label: 'job'.tr,
              content: user.value?.job ?? 'not_entered'.tr,
              onPressed: () {
                controller.showInput(
                    type: 'job', label: 'job'.tr, initText: user.value?.job);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'sake'.tr,
              content: user.value?.getTextDrink() ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                    type: 'isDrink',
                    label: 'sake'.tr,
                    map: {
                      'sake_can'.tr: true,
                      'sake_cannot'.tr: false,
                    },
                    initValue: user.value?.isDrink);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'smoke'.tr,
              content: user.value?.getTextSmoke() ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                    type: 'isSmoke',
                    label: 'smoke'.tr,
                    map: {
                      'smoke_can'.tr: true,
                      'smoke_cannot'.tr: false,
                    },
                    initValue: user.value?.isSmoke);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'family'.tr,
              content: user.value?.familyStatus ?? 'not_entered'.tr,
              onPressed: () {
                controller.showInput(
                    type: 'familyStatus',
                    label: 'family'.tr,
                    initText: user.value?.familyStatus);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'living_family'.tr,
              content: user.value?.getTextLiveFamily() ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                    type: 'livingWithFamily',
                    label: 'living_family'.tr,
                    map: {
                      'living_family_with'.tr: true,
                      'living_family_alone'.tr: false,
                    },
                    initValue: user.value?.livingWithFamily);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'hair_style'.tr,
              content: user.value?.hairStyle ?? 'not_entered'.tr,
              onPressed: () {
                controller.showInput(
                    type: 'hairStyle',
                    label: 'hair_style'.tr,
                    initText: user.value?.hairStyle);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'hair_color'.tr,
              content: user.value?.hairColor ?? 'not_entered'.tr,
              onPressed: () {
                controller.showInput(
                    type: 'hairColor',
                    label: 'hair_color'.tr,
                    initText: user.value?.hairColor);
              }),
          const Divider(),
        ],
      );
    });
  }

  Widget _buildChangePassword() {
    return InkWell(
      onTap: controller.showPasswordChange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'change_password'.tr,
            style: tNormalTextStyle.copyWith(
                color: getTextColorSecond(),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: kDefaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                '• • • • • • •',
                style: tNormalTextStyle.copyWith(
                    color: getTextColorSecond(), fontWeight: FontWeight.w500),
              )),
              getSvgImage('ic_arrow_down', color: getColorPrimary())
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    final _listWidget = <Widget>[
      const SizedBox(height: kSmallPadding),
      Row(children: [
        Text(
          'profile_image'.tr,
          style: tNormalTextStyle.copyWith(
              color: getTextColorSecond(),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 4),
        getSvgImage('ic_camera'),
      ]),
      const SizedBox(height: kDefaultPadding),
      _buildImagePicker(),
      const Divider(),
      Obx(() {
        return buildFieldInput(
            label: 'nick_name'.tr,
            content: user.value?.displayName?.isNotEmpty == true
                ? user.value?.displayName
                : 'enter_nick_name'.tr,
            onPressed: controller.showInputNickName);
      }),
      const Divider(),
      Obx(() {
        return buildFieldInput(
            label: 'birthday'.tr,
            content: user.value?.birthday == null
                ? 'not_entered'.tr
                : formatDateTime(
                    date: user.value?.birthday,
                    formatString: DateTimeFormatString.textBehind),
            onPressed: controller.showDateBottom);
      }),
      _hideAge(),
      const Divider(),
      Obx(() {
        String str = 'please_select'.tr;
        if (user.value?.cityName != null && user.value?.stateName != null) {
          str = '${user.value?.cityName} ${user.value?.stateName}';
        }
        return buildFieldInput(
          label: 'good_place'.tr,
          content: str,
          onPressed: controller.showSelectCity,
        );
      }),
      const Divider(),
      Obx(() {
        return buildFieldInput(
            label: 'description'.tr,
            content: user.value?.description?.isNotEmpty == true
                ? user.value?.description
                : 'not_entered'.tr,
            onPressed: controller.showInputDescription);
      }),
      if (casterAccount.value) ...[
        const Divider(),
        Obx(() {
          return buildFieldInput(
              label: 'today_mood'.tr,
              content: user.value?.tagInformation.isNotEmpty == true
                  ? null
                  : 'not_entered'.tr,
              widgetContent: user.value?.tagInformation.isNotEmpty == true
                  ? Wrap(
                      spacing: kSmallPadding,
                      runSpacing: kSmallPadding,
                      children: user.value!.tagInformation
                          .map((e) => Chip(
                              backgroundColor: kPrimaryColorFemale,
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: kPrimaryColorFemale),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              label: Text(
                                e,
                                style: tNormalTextStyle.copyWith(
                                    color: Colors.white, fontSize: 12),
                              )))
                          .toList(),
                    )
                  : null,
              onPressed: controller.showSelectTag);
        }),
      ],
      const Divider(),
      _buildInformation(),
      const SizedBox(height: kDefaultPadding),
      _buildChangePassword(),
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(kDefaultPadding),
      itemCount: _listWidget.length,
      itemBuilder: (BuildContext context, int index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('edit_profile'.tr),
        leadingWidth: 100,
        leading: backButtonText(callback: () {
          Get.back(id: getRouteMyPage());
        }),
      ),
      body: _buildBody(),
    );
  }
}
