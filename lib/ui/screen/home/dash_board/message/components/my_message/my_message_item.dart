import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/components/my_message/sent_my_message.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMessageItem extends StatelessWidget {
  const MyMessageItem({
    super.key,
    required this.model,
  });

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.7,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            formatDateTime(
                date: model.createdTime?.toDate(),
                formatString: DateTimeFormatString.hhmm),
            style: tNormalTextStyle.copyWith(fontSize: 8, color: kBorderColor),
          ),
          const SizedBox(width: 4),
          SentMyMessage(message: model.content ?? ''),
        ],
      ),
    );
  }
}
