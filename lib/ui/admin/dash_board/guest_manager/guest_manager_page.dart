import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/admin/components/data_table_user.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'guest_manager_controller.dart';

class GuestManagerPage extends GetView<GuestManagerController> {
  const GuestManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: GuestManagerWebPage(controller: controller),
      desktop: GuestManagerWebPage(controller: controller),
    ));
  }
}

class GuestManagerWebPage extends StatelessWidget {
  const GuestManagerWebPage({super.key, required this.controller});

  final GuestManagerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'guest_manager'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: kDefaultPadding),
            Expanded(
              child: Obx(() {
                return DataTableUser(
                  list: controller.list.toList(),
                  onScrollDown: controller.scrollDown,
                  isCaster: false,
                  isEmpty: controller.isEmpty.value,
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.registerUser,
        backgroundColor: kPrimaryColor,
        heroTag: "guest_manager",
        label: Text(
          'create_user'.tr,
          style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        icon: getSvgImage('my_page', color: kTextColorDark),
      ),
    );
  }
}
