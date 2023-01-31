import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
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
    return Padding(
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
    );
  }

  Widget buildFieldInput({
    required String label,
    required String content,
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
                  child: Text(
                content,
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
                    image: Image.network(
                      e.path,
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
              value: controller.hideYourAge.value,
              onChanged: controller.switchHideAge);
        })
      ],
    );
  }

  Widget _buildInformation() {
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
            label: 'height'.tr, content: 'unselected'.tr, onPressed: () {}),
        const Divider(),
        _buildItemInformation(
            label: 'address'.tr, content: 'not_entered'.tr, onPressed: () {}),
        const Divider(),
        _buildItemInformation(
            label: 'birth_place'.tr,
            content: 'not_entered'.tr,
            onPressed: () {}),
        const Divider(),
        _buildItemInformation(
            label: 'education'.tr, content: 'not_entered'.tr, onPressed: () {}),
        const Divider(),
        _buildItemInformation(
            label: 'annual_income'.tr,
            content: 'not_entered'.tr,
            onPressed: () {}),
        const Divider(),
        _buildItemInformation(
            label: 'job'.tr, content: 'not_entered'.tr, onPressed: () {}),
        const Divider(),
        _buildItemInformation(
            label: 'sake'.tr, content: 'not_entered'.tr, onPressed: () {}),
        const Divider(),
        _buildItemInformation(
            label: 'smoke'.tr, content: 'not_entered'.tr, onPressed: () {}),
        const Divider(),
        _buildItemInformation(
            label: 'family'.tr, content: 'not_entered'.tr, onPressed: () {}),
        const Divider(),
        _buildItemInformation(
            label: 'living_family'.tr,
            content: 'not_entered'.tr,
            onPressed: () {}),
        const Divider(),
      ],
    );
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
            content: controller.nickname.value.isEmpty
                ? 'enter_nick_name'.tr
                : controller.nickname.value,
            onPressed: controller.showInputNickName);
      }),
      const Divider(),
      Obx(() {
        return buildFieldInput(
            label: 'birthday'.tr,
            content: controller.dateTime.value == null
                ? 'not_entered'.tr
                : formatDateTime(
                    date: controller.dateTime.value,
                    formatString: DateTimeFormatString.textBehind),
            onPressed: controller.showDateBottom);
      }),
      _hideAge(),
      const Divider(),
      Obx(() {
        return buildFieldInput(
          label: 'good_place'.tr,
          content: controller.placeToPlay.value ?? 'please_select'.tr,
          onPressed: controller.showSelectCity,
        );
      }),
      const Divider(),
      Obx(() {
        return buildFieldInput(
            label: 'description'.tr,
            content: controller.description.value.isEmpty
                ? 'not_entered'.tr
                : controller.description.value,
            onPressed: controller.showInputDescription);
      }),
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
