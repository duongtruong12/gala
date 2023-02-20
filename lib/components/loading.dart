import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/global/globals_functions.dart';
import '../../utils/global/globals_variable.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;

  const LoadingOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: dismissKeyboard,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 1,
              child: AbsorbPointer(
                absorbing: loading.value,
                child: child,
              ),
            ),
            loading.value
                ? Opacity(
                    opacity: loading.value ? 1.0 : 0,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.7),
                      child: const Center(
                        child: SizedBox(
                            height: 32,
                            width: 32,
                            child: CircularProgressIndicator()),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
