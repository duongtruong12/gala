import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget getTransferRequestStatus({required String? status}) {
  Color getColorByStatus(String? status) {
    if (TransferStatus.waiting.name == status) {
      return kColorWaiting;
    } else if (TransferStatus.received.name == status) {
      return const Color(0xFF07C6D6);
    } else if (TransferStatus.alreadyTransfer.name == status) {
      return const Color(0xFF0FB783);
    } else {
      return const Color(0xFFF85959);
    }
  }

  return Container(
    decoration: BoxDecoration(
        color: getColorByStatus(status),
        borderRadius: const BorderRadius.all(Radius.circular(22))),
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: kSmallPadding),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        'transfer_status_$status'.tr,
        maxLines: 1,
        style: tButtonWhiteTextStyle.copyWith(fontSize: 14),
      ),
    ),
  );
}

Widget textEmpty({String? label}) {
  return Padding(
    padding: const EdgeInsets.all(kDefaultPadding),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          label ?? 'empty_list'.tr,
          style: tNormalTextStyle.copyWith(color: getTextColorSecond()),
        )
      ],
    ),
  );
}

showConfirmDialog({
  required String content,
  bool hideCancel = false,
  String? cancelText,
  String? confirmText,
  GestureTapCallback? onPressedCancel,
  GestureTapCallback? onPressedConfirm,
}) {
  if (Get.context != null) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            margin: const EdgeInsets.only(top: 56),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: casterAccount.value ? Colors.white : kMenuBk,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.close_rounded,
                        color: getTextColorSecond(),
                      ),
                      onTap: Get.back,
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: tNormalTextStyle.copyWith(color: getTextColorSecond()),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    hideCancel
                        ? const SizedBox()
                        : Expanded(
                            child: CustomButton(
                            widget: Text(
                              cancelText ?? 'no'.tr,
                              style: tButtonWhiteTextStyle,
                            ),
                            color: kGrayColor,
                            onPressed: () async {
                              Get.back();
                              if (onPressedCancel != null) {
                                onPressedCancel();
                              }
                            },
                          )),
                    const SizedBox(width: 8),
                    Expanded(
                        child: CustomButton(
                      widget: Text(
                        confirmText ?? 'yes'.tr,
                      ),
                      onPressed: () async {
                        Get.back();
                        if (onPressedConfirm != null) {
                          onPressedConfirm();
                        }
                      },
                    )),
                  ],
                )
              ],
            ),
          );
        });
  }
}

Widget backButtonText({required VoidCallback callback}) {
  return InkWell(
      onTap: callback,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: kDefaultPadding),
          getSvgImage('ic_back'),
          const SizedBox(width: 3),
          Text(
            'back'.tr,
            style: tNormalTextStyle.copyWith(color: getColorAppBar()),
          ),
        ],
      ));
}
