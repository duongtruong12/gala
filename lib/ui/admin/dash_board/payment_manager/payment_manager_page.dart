import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payment_manager_controller.dart';

class PaymentManagerPage extends GetView<PaymentManagerController> {
  const PaymentManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: PaymentManagerMobilePage(controller: controller),
      desktop: PaymentManagerMobilePage(controller: controller),
    ));
  }
}

class PaymentManagerMobilePage extends StatelessWidget {
  const PaymentManagerMobilePage({super.key, required this.controller});

  final PaymentManagerController controller;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
