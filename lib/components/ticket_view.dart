import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
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

  Widget _buildButton() {
    String text = 'apply'.tr;
    Color color = kPrimaryColorFemale;

    if ((user.value?.applyTickets.isNotEmpty == true &&
        user.value?.applyTickets.contains(model.id) == true)) {
      text = 'already_apply'.tr;
      color = kGrayColorFemale;
    }

    if ((user.value?.applyTickets.isNotEmpty == true &&
        user.value?.applyTickets.contains(model.id) == false)) {
      text = 'already_apply_another_ticket'.tr;
      color = kGrayColorFemale;
    }

    if (model.status == TicketStatus.done.name &&
        user.value?.applyTickets.contains(model.id) == true) {
      text = 'chat_group'.tr;
      color = kPrimaryColorFemale;
    }

    return CustomButton(
        onPressed: () async {
          if (model.status == TicketStatus.created.name &&
              user.value?.applyTickets.contains(model.id) != true) {
            await fireStoreProvider.applyTicket(model);
          }
          if ((user.value?.applyTickets.isNotEmpty == true &&
              user.value?.applyTickets.contains(model.id) == true)) {
            final messageGroupId =
                generateIdMessage(['admin', user.value!.id!]);
            await Get.toNamed(Routes.messageDetail,
                arguments: true, parameters: {'id': messageGroupId});
          }
        },
        color: color,
        borderRadius: kSmallPadding,
        widget: Text(
          text,
          style: tButtonWhiteTextStyle.copyWith(
              fontSize: 16, fontWeight: FontWeight.w500),
        ));
  }

  Widget _buildTicketInformation() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   '${model.cityName} ${model.stateName} ${formatDateTime(date: model.startTime, formatString: DateTimeFormatString.hhmm)}~',
              //   style: tNormalTextStyle.copyWith(
              //       fontWeight: FontWeight.w500, fontSize: 16),
              // ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '${model.cityName} ${model.stateName}',
                        style: tNormalTextStyle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    TextSpan(
                        text:
                            ' ${formatDateTime(date: model.startTime, formatString: DateTimeFormatString.hhmm)}~',
                        style: tNormalTextStyle.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16))
                  ],
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  _buildItemIcon(
                      content: model.durationDate?.tr ?? '',
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
        FutureBuilder<UserModel?>(
            future: fireStoreProvider.getUserDetail(id: model.createdUser),
            builder:
                (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
              final avatar = snapshot.data?.avatar;
              final displayText = snapshot.data?.displayName;
              final age = snapshot.data?.getAge();
              return Column(
                children: [
                  CustomCircleImage(
                      radius: 99,
                      image: CustomNetworkImage(
                        url: avatar,
                        height: 36,
                        width: 36,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    '${age ?? ''} ${displayText ?? ''}',
                    style: tNormalTextStyle.copyWith(fontSize: 10),
                  )
                ],
              );
            }),
      ],
    );
  }

  Widget _buildPoint() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'expected_point'.tr,
              style: tNormalTextStyle.copyWith(fontSize: 10),
            ),
            const SizedBox(height: kSmallPadding),
            Text(
              '${formatCurrency(model.expectedPoint)}~',
              style: tNormalTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: kSmallPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
            child: Obx(() {
              return _buildButton();
            }),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = kGrayColorFemale;

    if (model.status == TicketStatus.created.name ||
        model.status == TicketStatus.done.name) {
      color = kPrimaryColorFemale;
    }
    return Card(
      child: IntrinsicHeight(
        child: Row(
          children: [
            VerticalDivider(
              color: color,
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
