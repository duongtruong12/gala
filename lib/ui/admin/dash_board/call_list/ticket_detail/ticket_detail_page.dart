import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ticket_detail_controller.dart';

class TicketDetailPage extends GetView<TicketDetailController> {
  const TicketDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: TicketDetailWebPage(controller: controller),
      desktop: TicketDetailWebPage(controller: controller),
    ));
  }
}

class TicketDetailWebPage extends StatelessWidget {
  const TicketDetailWebPage({super.key, required this.controller});

  final TicketDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [],
        ),
      ),
    );
  }
}
