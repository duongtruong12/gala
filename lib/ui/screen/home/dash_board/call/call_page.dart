import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'call_controller.dart';

class CallPage extends GetView<CallController> {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: CallMobilePage(controller: controller),
      desktop: CallMobilePage(controller: controller),
    ));
  }
}

class CallMobilePage extends StatelessWidget {
  const CallMobilePage({super.key, required this.controller});

  final CallController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('message_list'.tr),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
