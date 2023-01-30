import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/female_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserItem extends StatelessWidget {
  final FemaleModel model;
  final VoidCallback onPressed;

  const UserItem({
    Key? key,
    required this.model,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 134,
          height: 163,
          child: InkWell(
              onTap: onPressed,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomNetworkImage(
                    url: model.avatar,
                    width: 134,
                    height: 163,
                    borderRadius: 0,
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: kDefaultPadding),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 0.2, 0.5, 1],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${model.age}${'age'.tr}  ${model.displayName}',
                          style: tNormalTextStyle.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: kTextColorPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '1${'hour'.tr}/${formatCurrency(model.point)}',
                          style: tNormalTextStyle.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: kTextColorSecond),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
        const SizedBox(width: kDefaultPadding),
      ],
    );
  }
}
