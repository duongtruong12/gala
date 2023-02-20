import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';

class ItemTarget extends StatelessWidget {
  final UserModel model;
  final VoidCallback onPressed;
  final bool femaleGender;

  const ItemTarget({
    Key? key,
    required this.model,
    required this.onPressed,
    this.femaleGender = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: kTextColorSecond,
                width: double.infinity,
                child: CustomNetworkImage(
                  url: model.avatar,
                  borderRadius: 0,
                ),
              ),
            ),
            Container(
              color:
                  femaleGender ? kItemHomeBackgroundFemale : kTextColorSecond,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getSvgImage('ic_star'),
                  const SizedBox(width: 4),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.getAge(),
                            style: tNormalTextStyle.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            model.displayName ?? '',
                            style: tNormalTextStyle.copyWith(
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      femaleGender == true
                          ? const SizedBox()
                          : Text(
                              formatCurrency(model.pointPer30Minutes,
                                  symbol: CurrencySymbol.pointPerMinutes),
                              style: tNormalTextStyle.copyWith(
                                  fontWeight: FontWeight.w500),
                            )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
