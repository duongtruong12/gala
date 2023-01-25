import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/error/404_page_controller.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorScreen extends GetView<ErrorController> {
  const ErrorScreen({super.key});

  Widget _buildWidgetScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: getLottieImage('404_error', boxFit: BoxFit.fitHeight)),
          const SizedBox(height: 16),
          TextButton(
              onPressed: () {
                Get.offAllNamed(Routes.home);
              },
              child: Text(
                'back_to_home'.tr,
                style: tNormalTextStyle.copyWith(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: Responsive(
          desktop: _buildWidgetScreen(context),
          mobile: _buildWidgetScreen(context),
        ),
      ),
    );
  }
}
