import 'package:base_flutter/components/gradient_text.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({
    super.key,
    required this.onPressed,
    this.femaleGender = false,
  });

  final bool femaleGender;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          femaleGender == true ? kPrimaryColorFemale : kPrimaryBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding),
          femaleGender == true
              ? Text(
                  'home_label_female'.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 19, fontWeight: FontWeight.w500),
                )
              : GradientText(
                  'home_label'.tr,
                  gradient: kButtonBackground,
                  style: tNormalTextStyle.copyWith(
                      fontSize: 19, fontWeight: FontWeight.w500),
                ),
          const SizedBox(height: kDefaultPadding),
          InkWell(
            onTap: onPressed,
            child: Container(
              decoration: const BoxDecoration(
                color: kTextColorSecond,
                borderRadius: radiusBorder,
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: kSmallPadding, horizontal: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getSvgImage('ic_soft'),
                      const SizedBox(width: 8),
                      Text(
                        'search'.tr,
                        style: tNormalTextStyle.copyWith(color: kTextColorDark),
                      ),
                    ],
                  ),
                  getSvgImage('ic_search')
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
