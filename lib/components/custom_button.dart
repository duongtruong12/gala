import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';

import '../../utils/const.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.widget,
    this.color,
    this.width,
    this.height,
    this.borderColor,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.textColor,
    this.gradient = kButtonBackground,
    this.loginPage = false,
  }) : super(key: key);

  final Future<void> Function() onPressed;
  final Widget widget;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;
  final EdgeInsets? padding;

  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Gradient gradient;
  final bool loginPage;
  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildButton() {
    pressed() async {
      if (mounted) isLoading = true;
      await widget.onPressed();
      if (mounted) isLoading = false;
    }

    final child = isLoading
        ? const CircularProgressIndicator(color: kTextColorSecond)
        : widget.widget;
    final gradient = widget.gradient;
    Color? color = widget.color;
    if (femaleGender.value && !widget.loginPage && widget.color == null) {
      color = kPrimaryColorFemale;
    }
    return InkWell(
      onTap: isLoading ? null : pressed,
      child: Container(
        key: widget.key,
        width: widget.width ?? double.infinity,
        height: widget.height ?? 48,
        decoration: BoxDecoration(
          gradient: color == null ? gradient : null,
          color: color,
          border: Border.all(
              color: color != null
                  ? widget.borderColor ?? Colors.transparent
                  : Colors.transparent,
              width: 1),
          borderRadius:
              BorderRadius.all(Radius.circular(widget.borderRadius ?? 0)),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }
}
