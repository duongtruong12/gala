import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/bottom_navigation_bar.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: MobileHomePage(controller: controller),
      desktop: MobileHomePage(controller: controller),
    ));
  }
}

class MobileHomePage extends StatelessWidget {
  final HomeController controller;

  const MobileHomePage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: controller.map.entries
              .map(
                (e) => Navigator(
                  key: Get.nestedKey(e.key),
                  initialRoute: e.value,
                  observers: [GetObserver((_) {}, Get.routing)],
                  onGenerateRoute: onGenerateRouteDashboard,
                ),
              )
              .toList(),
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigatorWidget(
          currentIndex: controller.currentIndex.value,
          onTap: controller.onTapItem,
          femaleGender: casterAccount.value,
        );
      }),
    );
  }
}
