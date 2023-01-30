import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget backButtonText({required VoidCallback callback}) {
  return TextButton(
      onPressed: callback,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          getSvgImage('ic_back'),
          const SizedBox(width: 3),
          Text(
            'back'.tr,
            style: tNormalTextStyle.copyWith(color: getColorAppBar()),
          ),
        ],
      ));
}
