import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/female_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemTarget extends StatelessWidget {
  final FemaleModel model;
  final VoidCallback onPressed;

  const ItemTarget({
    Key? key,
    required this.model,
    required this.onPressed,
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
                color: Colors.white,
                width: double.infinity,
                child: CustomNetworkImage(url: model.avatar),
              ),
            ),
            Container(
              color: Colors.white,
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
                            '${model.age}${'age'.tr}',
                            style: tNormalTextStyle.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            model.displayName ?? '',
                            style: tNormalTextStyle.copyWith(
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(
                        formatCurrency(model.point),
                        style: tNormalTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
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
