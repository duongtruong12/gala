import 'package:base_flutter/ui/screen/home/components/select_tag.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetTag extends StatelessWidget {
  const BottomSheetTag({super.key, required this.valueSetter});

  final ValueSetter<List> valueSetter;

  @override
  Widget build(BuildContext context) {
    final list = [
      Text(
        'today_mood'.tr,
        style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w600),
      ),
      const Divider(color: kTextColorDark),
      SelectTag(valueSetter: valueSetter)
    ];
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return list[index];
          },
        ),
      ),
    );
  }
}
