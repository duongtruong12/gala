import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_manager_controller.dart';

class ChatManagerPage extends GetView<ChatManagerController> {
  const ChatManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: ChatManagerMobilePage(controller: controller),
      desktop: ChatManagerMobilePage(controller: controller),
    ));
  }
}

class ChatManagerMobilePage extends StatelessWidget {
  const ChatManagerMobilePage({super.key, required this.controller});

  final ChatManagerController controller;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
