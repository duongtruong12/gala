import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Container(
          decoration: BoxDecoration(
            color: casterAccount.value
                ? kPrimaryBackgroundColorFemale
                : kPrimaryBackgroundColor,
            gradient: casterAccount.value
                ? null
                : const LinearGradient(
                    stops: [0.0, 0.5, 1.0],
                    colors: [
                      Colors.black,
                      Color(0xFF242424),
                      Colors.black,
                    ],
                  ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: SafeArea(child: child),
            ),
          )),
    );
  }
}
