import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const radiusBorder = BorderRadius.all(Radius.circular(99.0));

final defaultBorderRounded = OutlineInputBorder(
    borderRadius: radiusBorder,
    borderSide: BorderSide(color: getTextColorSecond(), width: 2));
final focusedBorderRounded = OutlineInputBorder(
    borderRadius: radiusBorder,
    borderSide: BorderSide(color: getColorPrimary(), width: 2));
const errorBorderRounded = OutlineInputBorder(
    borderRadius: radiusBorder,
    borderSide: BorderSide(color: kErrorColor, width: 2));

class FieldInput extends StatelessWidget {
  const FieldInput({super.key, required this.onInput});

  final ValueSetter<String> onInput;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      color: femaleGender.value ? kPrimaryBackgroundColorFemale : kMenuBk,
      child: Row(
        children: [
          getSvgImage('ic_add_input'),
          const SizedBox(width: kDefaultPadding),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'input_hint'.tr,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                focusedBorder: focusedBorderRounded,
                border: defaultBorderRounded,
                enabledBorder: defaultBorderRounded,
              ),
            ),
          ),
          const SizedBox(width: kDefaultPadding),
          InkWell(
            onTap: () {
              onInput(controller.text);
            },
            child: getSvgImage('ic_send'),
          )
        ],
      ),
    );
  }
}
