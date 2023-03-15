import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/admin/components/data_table_user.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'caster_manager_controller.dart';

class CasterManagerPage extends GetView<CasterManagerController> {
  const CasterManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: CasterManagerWebPage(controller: controller),
      desktop: CasterManagerWebPage(controller: controller),
    ));
  }
}

class CasterManagerWebPage extends StatelessWidget {
  const CasterManagerWebPage({super.key, required this.controller});

  final CasterManagerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'caster_manager'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: kDefaultPadding),
            Expanded(
              child: Obx(() {
                return DataTableUser(
                  list: controller.list.toList(),
                  onScrollDown: controller.scrollDown,
                  isEmpty: controller.checkEmpty(),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.registerUser,
        heroTag: "caster_manager",
        backgroundColor: kPrimaryColorFemale,
        label: Text(
          'create_user'.tr,
          style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        icon: getSvgImage('my_page', color: kTextColorDark),
      ),
    );
  }
}
