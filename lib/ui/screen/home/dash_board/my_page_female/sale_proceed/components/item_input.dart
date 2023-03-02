import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class ItemInputSale extends StatelessWidget {
  const ItemInputSale({
    super.key,
    required this.label,
    required this.content,
    required this.onTap,
  });

  final String label;
  final String? content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  label,
                  style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w500),
                )),
                Text(content ?? 'not_entered'.tr, style: tNormalTextStyle),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
