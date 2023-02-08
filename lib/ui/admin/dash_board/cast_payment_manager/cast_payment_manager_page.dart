import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cast_payment_manager_controller.dart';

class CastPaymentManagerPage extends GetView<CastPaymentManagerController> {
  const CastPaymentManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: CastPaymentManagerMobilePage(controller: controller),
      desktop: CastPaymentManagerMobilePage(controller: controller),
    ));
  }
}

class CastPaymentManagerMobilePage extends StatelessWidget {
  const CastPaymentManagerMobilePage({super.key, required this.controller});

  final CastPaymentManagerController controller;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
