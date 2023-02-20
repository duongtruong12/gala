import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';

class ChipItemSelect extends StatelessWidget {
  const ChipItemSelect({
    super.key,
    this.isSelect,
    required this.label,
    required this.value,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.textColor,
    this.selectedTextColor,
    this.borderColor,
    this.onPress,
  });

  final String value;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? selectedTextColor;
  final Color? selectedBackgroundColor;

  final bool? isSelect;
  final ValueSetter<String>? onPress;

  @override
  Widget build(BuildContext context) {
    Color bgColor = isSelect == true ? kTextColorSecond : Colors.black;
    Color textColor = isSelect == true ? Colors.black : kTextColorSecond;
    Color borderColor = kTextColorSecond;
    if (casterAccount.value) {
      bgColor = isSelect == true ? kPrimaryColorFemale : Colors.white;
      textColor = isSelect == true ? Colors.white : kPrimaryColorFemale;
      borderColor = kPrimaryColorFemale;
    }
    borderColor = this.borderColor ?? borderColor;
    if (isSelect == true) {
      bgColor = selectedBackgroundColor ?? bgColor;
      textColor = selectedTextColor ?? textColor;
    } else if (isSelect == false) {
      bgColor = backgroundColor ?? bgColor;
      textColor = this.textColor ?? textColor;
    }
    return InkWell(
      onTap: () {
        if (onPress != null) {
          onPress!(value);
        }
      },
      child: Chip(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          label: Text(
            label,
            style: tNormalTextStyle.copyWith(color: textColor, fontSize: 12),
          )),
    );
  }
}
