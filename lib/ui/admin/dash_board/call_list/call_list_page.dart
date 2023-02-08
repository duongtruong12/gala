import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'call_list_controller.dart';

class CallListPage extends GetView<CallListController> {
  const CallListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: CallListMobilePage(controller: controller),
      desktop: CallListMobilePage(controller: controller),
    ));
  }
}

class CallListMobilePage extends StatelessWidget {
  const CallListMobilePage({super.key, required this.controller});

  final CallListController controller;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
