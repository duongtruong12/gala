import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
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

  Widget buildFieldInput({
    required String label,
    required String content,
    required VoidCallback onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: tNormalTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kTextColorSecond),
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              content,
              style: tNormalTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: kTextColorSecond),
            )),
            getSvgImage('ic_arrow_down', color: kPrimaryColor)
          ],
        )
      ],
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              return Row(
                children: controller.listImage
                    .map((e) => Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: CustomCircleImage(
                            radius: 99,
                            image: Image.network(
                              e.path,
                              fit: BoxFit.cover,
                              height: 44,
                              width: 44,
                            ),
                          ),
                        ))
                    .toList(),
              );
            }),
          ),
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
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: kTextColorSecond),
        )),
        Obx(() {
          return Switch(
              value: controller.hideYourAge.value,
              onChanged: controller.switchHideAge);
        })
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSmallPadding),
          Row(children: [
            Text(
              'profile_image'.tr,
              style: tNormalTextStyle.copyWith(
                  color: kTextColorSecond, fontSize: 16),
            ),
            const SizedBox(width: 4),
            getSvgImage('ic_camera'),
          ]),
          const SizedBox(height: kDefaultPadding),
          _buildImagePicker(),
          const Divider(),
          buildFieldInput(
              label: 'nick_name'.tr,
              content: 'enter_nick_name'.tr,
              onPressed: () {}),
          const Divider(),
          buildFieldInput(
              label: 'birthday'.tr,
              content: formatDateTime(
                  date: DateTime.now(),
                  formatString: DateTimeFormatString.textBehind),
              onPressed: () {}),
          _hideAge(),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('edit_profile'.tr),
        leadingWidth: 100,
        leading: TextButton(
            onPressed: () {
              Get.back(id: RouteId.myPage);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getSvgImage('ic_back'),
                const SizedBox(width: 3),
                Text(
                  'back'.tr,
                  style: tNormalTextStyle.copyWith(color: kTextColorPrimary),
                ),
              ],
            )),
      ),
      body: _buildBody(),
    );
  }
}
