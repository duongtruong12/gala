import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget textEmpty({String? label}) {
  return Padding(
    padding: const EdgeInsets.all(kDefaultPadding),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          label ?? 'empty_list'.tr,
          style: tNormalTextStyle.copyWith(color: getTextColorSecond()),
        )
      ],
    ),
  );
}

Widget backButtonText({required VoidCallback callback}) {
  return InkWell(
      onTap: callback,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: kDefaultPadding),
          getSvgImage('ic_back'),
          const SizedBox(width: 3),
          Text(
            'back'.tr,
            style: tNormalTextStyle.copyWith(color: getColorAppBar()),
          ),
        ],
      ));
}
