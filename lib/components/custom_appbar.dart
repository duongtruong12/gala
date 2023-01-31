import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appbarCustom(
    {Widget? title,
    Widget? leading,
    Color? backgroundColor,
    List<Widget>? actions,
    bool flexibleSpace = false,
    bool isDark = false,
    bool automaticallyImplyLeading = true,
    PreferredSizeWidget? bottom,
    double? elevation = 3,
    double? leadingWidth}) {
  return AppBar(
      title: title,
      actions: actions,
      iconTheme: IconThemeData(
          color: femaleGender.value
              ? kPrimaryBackgroundColorFemale
              : kTextColorPrimary),
      actionsIconTheme: IconThemeData(
          color: femaleGender.value
              ? kPrimaryBackgroundColorFemale
              : kTextColorPrimary),
      bottom: bottom,
      leading: leading,
      backgroundColor: backgroundColor,
      leadingWidth: leadingWidth,
      titleTextStyle: tNormalTextStyle.copyWith(
          color: kTextColorSecond, fontSize: 18, fontWeight: FontWeight.w500),
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: elevation);
}
