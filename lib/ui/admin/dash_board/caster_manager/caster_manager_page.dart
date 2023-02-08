import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'caster_manager_controller.dart';

class CasterManagerPage extends GetView<CasterManagerController> {
  const CasterManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: CasterManagerMobilePage(controller: controller),
      desktop: CasterManagerMobilePage(controller: controller),
    ));
  }
}

class CasterManagerMobilePage extends StatelessWidget {
  const CasterManagerMobilePage({super.key, required this.controller});

  final CasterManagerController controller;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
