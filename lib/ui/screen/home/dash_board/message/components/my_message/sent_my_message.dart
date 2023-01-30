import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:get/get.dart';

class SentMyMessage extends StatelessWidget {
  final String message;

  const SentMyMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper8(
          type: BubbleType.sendBubble, radius: kSmallPadding),
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(kSmallPadding),
      backGroundColor: getColorPrimary(),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.7,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: kSmallPadding),
          child: Text(
            message,
            style: tNormalTextStyle.copyWith(
                fontSize: 12, color: getTextColorButton()),
          ),
        ),
      ),
    );
  }
}
