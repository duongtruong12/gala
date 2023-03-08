import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

class TicketCreatedMessage extends StatelessWidget {
  const TicketCreatedMessage({
    super.key,
    required this.ticketId,
    required this.content,
    required this.onSwitchDetail,
  });

  final String? ticketId;
  final String? content;
  final Future<void> Function() onSwitchDetail;

  Widget _buildItemIcon({required String content, required String icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage(icon, color: kPrimaryColor),
        const SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(top: kSmallPadding),
          child: Text(
            content,
            style: tNormalTextStyle.copyWith(
                fontWeight: FontWeight.w500, color: Colors.white),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Ticket?>(
        future: fireStoreProvider.getTicketDetail(
            id: ticketId, source: Source.cache),
        builder: (BuildContext context, AsyncSnapshot<Ticket?> snapshot) {
          final ticket = snapshot.data;
          Widget item = const Center(
            child: SizedBox(
              height: 32,
              width: 32,
              child: CircularProgressIndicator(),
            ),
          );
          if (snapshot.connectionState == ConnectionState.done) {
            if (ticket != null) {
              if (user.value?.typeAccount == TypeAccount.admin.name) {
                item = Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      content ?? '',
                      textAlign: TextAlign.center,
                      style: tButtonWhiteTextStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: kSmallPadding),
                    _buildItemIcon(
                        content: ticket.durationDate?.tr ?? '',
                        icon: 'ic_start_time'),
                    const SizedBox(width: kDefaultPadding),
                    _buildItemIcon(
                        content: '${ticket.numberPeople}${'number_people'.tr}',
                        icon: 'ic_number_people'),
                    const SizedBox(width: kDefaultPadding),
                    _buildItemIcon(
                        content: formatDateTime(
                            date: ticket.startTime,
                            formatString: DateTimeFormatString.yyyyMMddhhMM),
                        icon: 'ic_start_time'),
                    const SizedBox(width: kDefaultPadding),
                    if (user.value?.typeAccount == TypeAccount.admin.name)
                      CustomButton(
                          onPressed: onSwitchDetail,
                          color: kPrimaryColor,
                          widget: Text(
                            'detail'.tr,
                            style: tButtonWhiteTextStyle,
                          ))
                  ],
                );
              } else {
                item = Text(
                  sprintf('ticket_created_content'.tr, [
                    '${ticket.numberPeople}',
                    formatDateTime(
                        date: ticket.startTime,
                        formatString: DateTimeFormatString.yyyyMMddhhMM),
                    '${ticket.cityName} ${ticket.stateName}',
                    ticket.durationDate?.tr ?? '',
                  ]),
                  textAlign: TextAlign.center,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                );
              }
            } else {
              return const SizedBox();
            }
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: kGrayColor,
                alignment: Alignment.center,
                width: Get.width * 0.7,
                padding: const EdgeInsets.all(kDefaultPadding),
                child: item,
              ),
            ],
          );
        });
  }
}
