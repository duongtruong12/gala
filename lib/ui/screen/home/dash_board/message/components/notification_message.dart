import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';

class NotificationMessage extends StatelessWidget {
  const NotificationMessage({
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
        Text(
          content ?? '',
          style: tNormalTextStyle.copyWith(fontSize: 12, color: kBorderColor),
        )
      ],
    );
  }
}
