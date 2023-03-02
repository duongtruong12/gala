import 'dart:async';

import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_expanded_view.dart';
import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/components/chip_item_select.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandedView extends StatelessWidget {
  const ExpandedView(
      {super.key,
      required this.ticketId,
      required this.expanded,
      required this.onPressed,
      required this.list});

  final String? ticketId;
  final bool expanded;
  final Future<void> Function() onPressed;
  final List<CountTimeModel> list;

  Widget _buildReservationItem(
      {required String label, required String? content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getSvgImage('ic_$label', color: getTextColorSecond()),
                const SizedBox(width: 4),
                Text(
                  label.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: getTextColorSecond()),
                )
              ],
            ),
          ),
          Text(
            ': ${content ?? ''}',
            style: tButtonWhiteTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: getTextColorSecond()),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandedSection(
      expand: expanded,
      child: FutureBuilder<Ticket?>(
        future: fireStoreProvider.getTicketDetail(
            id: ticketId, source: Source.cache),
        builder: (context, data) {
          final ticket = data.data;
          if (ticket == null) {
            return const CircularProgressIndicator();
          }
          return Container(
            color:
                casterAccount.value ? const Color(0xFFE6E6E6) : kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildReservationItem(
                          label: 'start_time',
                          content: ticket.startTimeAfter?.tr),
                    ),
                    Expanded(
                      child: _buildReservationItem(
                          label: 'required_time',
                          content: ticket.durationDate?.tr),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildReservationItem(
                          label: 'meeting_place', content: ticket.stateName),
                    ),
                    Expanded(
                      child: _buildReservationItem(
                          label: 'number_people',
                          content: '${ticket.numberPeople ?? 0}${'people'.tr}'),
                    ),
                  ],
                ),
                casterAccount.value
                    ? ExpandedViewFemale(
                        model: list.firstWhere(
                            (element) => element.id == user.value?.id),
                        onPressed: onPressed,
                      )
                    : ExpandedViewMale(list: list),
                const SizedBox(height: kSmallPadding),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExpandedViewFemale extends StatefulWidget {
  const ExpandedViewFemale(
      {Key? key, required this.model, required this.onPressed})
      : super(key: key);
  final CountTimeModel model;
  final Future<void> Function() onPressed;

  @override
  _ExpandedViewFemaleState createState() => _ExpandedViewFemaleState();
}

class _ExpandedViewFemaleState extends State<ExpandedViewFemale> {
  Timer? timer;
  String str = printDuration(const Duration(seconds: 0));

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void startTime() {
    timer?.cancel();
    str = printDuration(const Duration(seconds: 0));
    if (widget.model.startDate != null) {
      if (widget.model.endDate != null) {
        str = printDuration(
            widget.model.endDate!.difference(widget.model.startDate!));
      } else {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          str =
              printDuration(DateTime.now().difference(widget.model.startDate!));
          if (mounted) setState(() {});
        });
      }
    }
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    startTime();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          str,
          style: tButtonWhiteTextStyle.copyWith(
              fontSize: 18, fontWeight: FontWeight.w600, color: kTextColorDark),
        ),
        const SizedBox(width: kSmallPadding),
        widget.model.startDate != null && widget.model.endDate != null
            ? const SizedBox()
            : CustomButton(
                onPressed: widget.onPressed,
                color: kPrimaryColorFemale,
                borderColor: kPrimaryColorFemale,
                width: 140,
                height: 42,
                borderRadius: kSmallPadding,
                widget: Text(
                  widget.model.startDate != null
                      ? 'end_count_time'.tr
                      : 'start_count_time'.tr,
                )),
      ],
    );
  }
}

class ExpandedViewMale extends StatefulWidget {
  const ExpandedViewMale({Key? key, required this.list}) : super(key: key);
  final List<CountTimeModel> list;

  @override
  _ExpandedViewMaleState createState() => _ExpandedViewMaleState();
}

class _ExpandedViewMaleState extends State<ExpandedViewMale> {
  Timer? timer;
  final map = <String, Duration>{};

  @override
  void initState() {
    super.initState();
    if (widget.list.isNotEmpty) {
      for (var element in widget.list) {
        if (element.startDate == null) {
          map.putIfAbsent(element.id!, () => const Duration(seconds: 0));
          continue;
        }
        if (element.endDate == null) {
          map.putIfAbsent(
              element.id!, () => DateTime.now().difference(element.startDate!));
          continue;
        }
        map.putIfAbsent(
            element.id!, () => element.endDate!.difference(element.startDate!));
      }
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      for (var element in widget.list) {
        if (element.endDate == null && element.startDate != null) {
          map[element.id!] = DateTime.now().difference(element.startDate!);
        }
      }
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      children: map.entries
          .map(
            (e) => FutureBuilder(
                future: fireStoreProvider.getUserDetail(
                    id: e.key, source: Source.cache),
                builder: (context, data) {
                  final userData = data.data;
                  return ChipItemSelect(
                    value:
                        '${userData?.displayName ?? ''} ${printDuration(e.value)}',
                    label:
                        '${userData?.displayName ?? ''} ${printDuration(e.value)}',
                  );
                }),
          )
          .toList(),
    );
  }
}
