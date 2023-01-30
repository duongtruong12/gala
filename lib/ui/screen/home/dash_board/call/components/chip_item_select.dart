import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';

class ChipItemSelect extends StatelessWidget {
  const ChipItemSelect({
    super.key,
    this.isSelect,
    required this.text,
    this.onPress,
  });

  final String text;
  final bool? isSelect;
  final ValueSetter<String>? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPress != null) {
          onPress!(text);
        }
      },
      child: Chip(
          backgroundColor: isSelect == true ? kTextColorSecond : Colors.black,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: kTextColorSecond),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          label: Text(
            text,
            style: tNormalTextStyle.copyWith(
                color: isSelect == true ? Colors.black : kTextColorSecond,
                fontSize: 12),
          )),
    );
  }
}
