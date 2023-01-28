import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';

class MessageGroupItem extends StatelessWidget {
  const MessageGroupItem({
    super.key,
    required this.model,
  });

  final MessageGroupModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomCircleImage(
            radius: 99,
            image: CustomNetworkImage(
              url: model.avatar,
              height: 50,
              width: 50,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model.title ?? '',
                style: tNormalTextStyle.copyWith(
                    color: kTextColorSecond,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                model.lastMessage?.content ?? '',
                style: tNormalTextStyle.copyWith(
                    color: kBorderColor, fontSize: 12),
              ),
            ],
          )),
          const SizedBox(width: 16),
          Text(
            formatDateTime(
                date: model.lastMessage?.createdTime?.toDate(),
                formatString: DateTimeFormatString.yyyyMMdd),
            style: tNormalTextStyle.copyWith(fontSize: 8, color: kBorderColor),
          )
        ],
      ),
    );
  }
}
