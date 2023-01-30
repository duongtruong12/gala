import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketView extends StatelessWidget {
  const TicketView({
    super.key,
    required this.model,
  });

  final Ticket model;

  Widget _buildItemIcon({required String content, required String icon}) {
    return Row(
      children: [
        getSvgImage(icon),
        const SizedBox(width: 4),
        Text(
          content,
          style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _buildTicketInformation() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model.area} ${model.peopleApply?.length}/${model.numberPeople} ${formatDateTime(date: model.createdDate?.toDate(), formatString: DateTimeFormatString.hhmm)}~',
                style: tNormalTextStyle.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  _buildItemIcon(
                      content: '${model.requiredTime}${'hour'.tr}',
                      icon: 'ic_start_time'),
                  const SizedBox(width: kDefaultPadding),
                  _buildItemIcon(
                      content: '${model.numberPeople}${'number_people'.tr}',
                      icon: 'ic_number_people'),
                ],
              )
            ],
          ),
        ),
        Column(
          children: [
            const CustomCircleImage(
                radius: 99,
                image: CustomNetworkImage(
                  url: null,
                  height: 36,
                  width: 36,
                )),
            const SizedBox(height: 4),
            Text(
              '40歳 たなか',
              style: tNormalTextStyle.copyWith(fontSize: 10),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildPoint() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'expected_point'.tr,
              style: tNormalTextStyle.copyWith(fontSize: 10),
            ),
            const SizedBox(height: 4),
            Text(
              '${formatCurrency(model.expectedPoint)}~',
              style: tNormalTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            Row(
              children: [
                Chip(
                  label: Text(
                    'extension_point'.tr,
                    style: tButtonWhiteTextStyle.copyWith(fontSize: 9),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(99))),
                  padding: const EdgeInsets.all(2),
                ),
                const SizedBox(width: kSmallPadding),
                Text(
                  '+${formatCurrency(model.extension)}',
                  style: tNormalTextStyle.copyWith(
                      color: kPrimaryColorFemale, fontWeight: FontWeight.w500),
                ),
                Text(
                  '  / 1${'hour'.tr}',
                  style: tNormalTextStyle.copyWith(fontSize: 10),
                )
              ],
            ),
          ],
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding * 2),
            child: CustomButton(
                onPressed: () async {},
                color: kGrayColorFemale,
                borderRadius: kSmallPadding,
                widget: Text(
                  'apply'.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w500),
                )),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Row(
          children: [
            const VerticalDivider(
              color: kGrayColorFemale,
              width: 5,
              thickness: 5,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTicketInformation(),
                  const Divider(),
                  _buildPoint(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
