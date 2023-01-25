import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_page_controller.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: MyPageMobilePage(controller: controller),
      desktop: MyPageMobilePage(controller: controller),
    ));
  }
}

class MyPageMobilePage extends StatelessWidget {
  const MyPageMobilePage({super.key, required this.controller});

  final MyPageController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'MyPage',
        style: tNormalTextStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
