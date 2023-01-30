import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointWidget extends StatelessWidget {
  const PointWidget({
    super.key,
    required this.point,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final int? point;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'points_available'.tr,
            style: tNormalTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: kDefaultPadding),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '10000',
                style: tNormalTextStyle.copyWith(
                    color: kTextColorPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.w500)),
            const TextSpan(
              text: 'pt',
              style: tNormalTextStyle,
            )
          ])),
          const SizedBox(height: kDefaultPadding),
          onPressed == null
              ? Text(
                  'cart_content'.tr,
                  style: tNormalTextStyle.copyWith(
                      fontSize: 12, color: kTextColorDarkLight),
                )
              : CustomButton(
                  onPressed: () async {
                    onPressed!();
                  },
                  color: Colors.transparent,
                  width: 164,
                  height: 30,
                  borderColor: kMenuBk,
                  borderRadius: kSmallPadding,
                  widget: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getSvgImage('ic_cart'),
                      const SizedBox(width: kSmallPadding),
                      Text('buy_points'.tr, style: tNormalTextStyle),
                    ],
                  ))
        ],
      ),
    );
  }
}