import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/gradient_text.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/web_navigation_bar.dart';
import 'home_admin_controller.dart';

class HomeAdminPage extends GetView<HomeAdminController> {
  const HomeAdminPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: MobileHomeAdminPage(controller: controller),
      desktop: MobileHomeAdminPage(controller: controller),
    ));
  }
}

class MobileHomeAdminPage extends StatelessWidget {
  final HomeAdminController controller;

  const MobileHomeAdminPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        centerTitle: false,
        title: GradientText(
          'Claha',
          gradient: kButtonBackground,
          style: tNormalTextStyle.copyWith(
              fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(() {
        return Row(
          children: [
            WebNavigator(
              currentIndex: controller.currentIndex.value,
              onTap: controller.onTapItem,
            ),
            Expanded(
              child: IndexedStack(
                index: controller.currentIndex.value,
                children: controller.map.entries
                    .map(
                      (e) => Navigator(
                        key: Get.nestedKey(e.key),
                        initialRoute: e.value,
                        observers: [GetObserver((_) {}, Get.routing)],
                        onGenerateRoute: onGenerateRouteDashboardAdmin,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      }),
    );
  }
}
