import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';

class NotificationBorderMessage extends StatelessWidget {
  const NotificationBorderMessage({
    super.key,
    required this.content,
  });

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          color: kGrayColor,
          alignment: Alignment.center,
          constraints: const BoxConstraints(
            minHeight: 60,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Text(
            content ?? '',
            textAlign: TextAlign.center,
            style: tNormalTextStyle.copyWith(color: kTextColorSecond),
          ),
        ),
      ],
    );
  }
}
