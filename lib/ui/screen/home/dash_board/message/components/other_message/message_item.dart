import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/components/other_message/sent_message.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
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
    return FutureBuilder<UserModel?>(
        future: fireStoreProvider.getUserDetail(id: model.userId),
        builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
          final u = snapshot.data;
          return SizedBox(
            width: Get.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCircleImage(
                    radius: 99, image: CustomNetworkImage(url: u?.avatar)),
                const SizedBox(width: kSmallPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      u?.displayName ?? '',
                      style: tNormalTextStyle.copyWith(
                          color: getTextColorSecond(), fontSize: 10),
                    ),
                    const SizedBox(height: kSmallPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SentMessage(message: model.content ?? ''),
                        const SizedBox(width: 4),
                        Text(
                          formatDateTime(
                              date: model.createdTime,
                              formatString:
                                  DateTimeFormatString.textBehindHour),
                          style: tNormalTextStyle.copyWith(
                              fontSize: 8, color: kBorderColor),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
