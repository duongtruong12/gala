import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  BottomNavigationBarItem _buildItem({required String label, required index}) {
    final color =
        index == controller.currentIndex.value ? kPrimaryColor : kMenuGray;
    return BottomNavigationBarItem(
      icon: getSvgImage(
          index == controller.currentIndex.value ? '$label${'_select'}' : label,
          color: color),
      backgroundColor: kPrimaryBackgroundColor,
      label: label.tr,
    );
  }

  Map<int, String> _buildTab() {
    return {
      RouteId.search: Routes.search,
      RouteId.message: Routes.message,
      RouteId.call: Routes.call,
      RouteId.myPage: Routes.myPage,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: _buildTab()
              .entries
              .map(
                (e) => Navigator(
                  key: Get.nestedKey(e.key),
                  initialRoute: e.value,
                  onGenerateRoute: onGenerateRouteDashboard,
                ),
              )
              .toList(),
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: [
            _buildItem(label: 'search', index: 0),
            _buildItem(label: 'message', index: 1),
            _buildItem(label: 'call', index: 2),
            _buildItem(label: 'my_page', index: 3),
          ],
          currentIndex: controller.currentIndex.value,
          onTap: controller.onTapItem,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kMenuGray,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: tNormalTextStyle.copyWith(color: kPrimaryColor),
          unselectedLabelStyle: tNormalTextStyle.copyWith(color: kMenuGray),
        );
      }),
    );
  }
}
