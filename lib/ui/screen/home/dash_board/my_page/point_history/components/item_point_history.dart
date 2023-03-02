import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/model/point_cost_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemPointHistory extends StatelessWidget {
  const ItemPointHistory({super.key, required this.model});

  final PointCostModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      formatDateTime(
                          date: model.createTime,
                          formatString: DateTimeFormatString.textBehindHour),
                      style: tNormalTextStyle.copyWith(
                          color: getTextColorSecond(), fontSize: 12),
                    ),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      children: [
                        Text(
                          'reason_${model.reason}'.tr,
                          style: tNormalTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: getTextColorSecond()),
                        ),
                        const SizedBox(width: kDefaultPadding),
                        if (model.reason ==
                                PointReason.remittancePayment.name &&
                            casterAccount.value)
                          getTransferRequestStatus(status: model.status)
                      ],
                    )
                  ],
                ),
              ),
              Text(
                '${(model.point ?? 0) > 0 ? '+' : ''}${formatCurrency(model.point)}',
                style: tNormalTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: getTextColorSecond()),
              )
            ]),
        const Divider(),
      ],
    );
  }
}
