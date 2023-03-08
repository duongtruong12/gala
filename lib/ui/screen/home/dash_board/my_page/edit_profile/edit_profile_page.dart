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
                controller.selectCity(
                    type: 'address',
                    label: 'address'.tr,
                    initText: user.value?.address);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'birth_place'.tr,
              content: user.value?.birthPlace ?? 'not_entered'.tr,
              onPressed: () {
                controller.selectCity(
                    type: 'birthPlace',
                    label: 'birth_place'.tr,
                    initText: user.value?.birthPlace);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'education'.tr,
              content: user.value?.education ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                  type: 'education',
                  label: 'education'.tr,
                  initValue: user.value?.education,
                  map: {
                    '短大/専門学校卒': '短大/専門学校卒',
                    '高校卒': '高校卒',
                    '大学卒': '大学卒',
                    '大学院卒': '大学院卒',
                    'その他': 'その他',
                  },
                );
              }),
          const Divider(),
          _buildItemInformation(
              label: 'annual_income'.tr,
              content: user.value?.annualIncome ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                  type: 'annualIncome',
                  label: 'annual_income'.tr,
                  initValue: '${user.value?.annualIncome ?? 0}',
                  map: {
                    '200万未満': '200万未満',
                    '200万～400万': '200万～400万',
                    '400万～600万': '400万～600万',
                    '600万～800万': '600万～800万',
                    '800万～1000万': '800万～1000万',
                    '1000万～1500万': '1000万～1500万',
                    '1500万～2000万': '1500万～2000万',
                    '2000万～3000万': '2000万～3000万',
                    '3000万～4000万': '3000万～4000万',
                    '4000万～5000万': '4000万～5000万',
                    '5000万～1億': '5000万～1億',
                    '1億以上': '1億以上',
                  },
                );
              }),
          const Divider(),
          _buildItemInformation(
              label: 'job'.tr,
              content: user.value?.job ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                  type: 'job',
                  label: 'job'.tr,
                  initValue: user.value?.job,
                  map: {
                    '会社員': '会社員',
                    '医者': '医者',
                    '弁護士': '弁護士',
                    '公認会計士': '公認会計士',
                    '経営者・役員': '経営者・役員',
                    '公務員': '公務員',
                    '事務員': '事務員',
                    '大手商社': '大手商社',
                    '外資金融': '外資金融',
                    '大手企業': '大手企業',
                    'クリエイター': 'クリエイター',
                    'ＩＴ関連': 'ＩＴ関連',
                    'パイロット': 'パイロット',
                    '芸能・モデル': '芸能・モデル',
                    'アパレル': 'アパレル',
                    'アナウンサー': 'アナウンサー',
                    '保育士': '保育士',
                    '自由業': '自由業',
                    '学生': '学生',
                    '上場企業': '上場企業',
                    '金融': '金融',
                    'コンサル': 'コンサル',
                    '教育関連': '教育関連',
                    '不動産': '不動産',
                    '建築関連': '建築関連',
                    'WEB業界': 'WEB業界',
                    'エンタメ': 'エンタメ',
                    '広告': '広告',
                    'マスコミ': 'マスコミ',
                    '接客業': '接客業',
                    'その他': 'その他',
                  },
                );
              }),
          const Divider(),
          _buildItemInformation(
              label: 'sake'.tr,
              content: user.value?.sake ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                    type: 'sake',
                    label: 'sake'.tr,
                    map: {
                      '飲む': '飲む',
                      '飲まない': '飲まない',
                      'ときどき飲む': 'ときどき飲む',
                    },
                    initValue: user.value?.sake);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'smoke'.tr,
              content: user.value?.smoke ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                    type: 'smoke',
                    label: 'smoke'.tr,
                    map: {
                      '吸う': '吸う',
                      '吸わない': '吸わない',
                      '非禁煙者の前では吸わない': '非禁煙者の前では吸わない',
                      '相手が嫌ならやめる': '相手が嫌ならやめる',
                    },
                    initValue: user.value?.smoke);
              }),
          const Divider(),
          _buildItemInformation(
              label: 'family'.tr,
              content: user.value?.familyStatus ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                    type: 'familyStatus',
                    label: 'family'.tr,
                    initValue: user.value?.familyStatus,
                    map: {
                      '長男': '長男',
                      '次男': '次男',
                      '三男': '三男',
                      'その他': 'その他',
                    });
              }),
          const Divider(),
          _buildItemInformation(
              label: 'living_family'.tr,
              content: user.value?.livingFamily ?? 'not_entered'.tr,
              onPressed: () {
                controller.showSelectLabel(
                    type: 'livingFamily',
                    label: 'living_family'.tr,
                    map: {
                      '一人暮らし': '一人暮らし',
                      'ペットと一緒': 'ペットと一緒',
                      '実家暮らし': '実家暮らし',
                    },
                    initValue: user.value?.livingFamily);
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
