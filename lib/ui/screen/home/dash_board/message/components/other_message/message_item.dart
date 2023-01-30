import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/components/other_message/sent_message.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.model,
  });

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomCircleImage(
              radius: 99, image: CustomNetworkImage(url: null)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: kSmallPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model.userId ?? '',
                    style: tNormalTextStyle.copyWith(
                        color: getTextColorSecond(), fontSize: 10),
                  ),
                  const SizedBox(height: kSmallPadding),
                  SentMessage(message: model.content ?? ''),
                ],
              ),
              const SizedBox(width: 4),
              Text(
                formatDateTime(
                    date: model.createdTime?.toDate(),
                    formatString: DateTimeFormatString.hhmm),
                style:
                    tNormalTextStyle.copyWith(fontSize: 8, color: kBorderColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
