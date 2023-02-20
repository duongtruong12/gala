import 'package:base_flutter/components/loading.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool loadingWrap;

  const Background({Key? key, required this.child, this.loadingWrap = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widget = Container(
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
        ));
    return WillPopScope(
        child: loadingWrap
            ? LoadingOverlay(
                child: widget,
              )
            : widget,
        onWillPop: () async {
          Get.back();
          return Future.value(true);
        });
  }
}
