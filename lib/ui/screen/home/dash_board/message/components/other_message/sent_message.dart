import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:get/get.dart';

class SentMessage extends StatelessWidget {
  final String message;

  const SentMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper8(
          type: BubbleType.receiverBubble, radius: kSmallPadding),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(
          left: kSmallPadding, right: kSmallPadding, top: kSmallPadding),
      backGroundColor: kTextColorSecond,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.7,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: kSmallPadding),
          child: Text(
            message,
            style: tNormalTextStyle.copyWith(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
