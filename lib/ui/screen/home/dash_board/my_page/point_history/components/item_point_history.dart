import 'package:base_flutter/model/point_cost_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemPointHistory extends StatelessWidget {
  const ItemPointHistory({super.key, required this.model});

  final PointCostModel model;

  Color getColorByStatus(String? status) {
    if (TransferStatus.waiting.name == status) {
      return kColorWaiting;
    } else if (TransferStatus.received.name == status) {
      return const Color(0xFF07C6D6);
    } else if (TransferStatus.alreadyTransfer.name == status) {
      return const Color(0xFF0FB783);
    } else {
      return const Color(0xFFF85959);
    }
  }

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
                          date: model.createTime?.toDate(),
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
                        if (model.status != null)
                          Container(
                            decoration: BoxDecoration(
                                color: getColorByStatus(model.status),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(22))),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: kSmallPadding),
                            child: Text(
                              'transfer_status_${model.status}'.tr,
                              style:
                                  tButtonWhiteTextStyle.copyWith(fontSize: 14),
                            ),
                          )
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
