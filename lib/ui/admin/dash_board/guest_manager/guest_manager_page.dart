import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'guest_manager_controller.dart';

class GuestManagerPage extends GetView<GuestManagerController> {
  const GuestManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: GuestManagerMobilePage(controller: controller),
      desktop: GuestManagerMobilePage(controller: controller),
    ));
  }
}

class GuestManagerMobilePage extends StatelessWidget {
  const GuestManagerMobilePage({super.key, required this.controller});

  final GuestManagerController controller;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
