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
    bool centerTitle = true,
    bool automaticallyImplyLeading = true,
    PreferredSizeWidget? bottom,
    double height = kToolbarHeight,
    double? elevation = 3,
    double? leadingWidth}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: AppBar(
        title: title,
        toolbarHeight: height,
        actions: actions,
        iconTheme: IconThemeData(
            color: casterAccount.value
                ? kPrimaryBackgroundColorFemale
                : kTextColorPrimary),
        actionsIconTheme: IconThemeData(
            color: casterAccount.value
                ? kPrimaryBackgroundColorFemale
                : kTextColorPrimary),
        bottom: bottom,
        leading: leading,
        backgroundColor: backgroundColor,
        leadingWidth: leadingWidth,
        titleTextStyle: tNormalTextStyle.copyWith(
            color: kTextColorSecond, fontSize: 18, fontWeight: FontWeight.w500),
        centerTitle: centerTitle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        elevation: elevation),
  );
}
