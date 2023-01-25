import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSizeWidget appbarCustom(
    {Widget? title,
    Widget? leading,
    Color? backgroundColor = kPrimaryBackgroundColor,
    List<Widget>? actions,
    IconThemeData? iconTheme,
    bool flexibleSpace = false,
    bool isDark = false,
    bool automaticallyImplyLeading = true,
    PreferredSizeWidget? bottom,
    double? elevation = 3}) {
  return AppBar(
      title: title,
      actions: actions,
      iconTheme: iconTheme,
      bottom: bottom,
      leading: leading,
      titleTextStyle: tNormalTextStyle.copyWith(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light),
      backgroundColor: backgroundColor,
      elevation: elevation);
}
