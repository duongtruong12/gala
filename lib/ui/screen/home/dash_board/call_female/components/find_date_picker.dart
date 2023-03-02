import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FindDatePicker extends StatefulWidget {
  const FindDatePicker(
      {super.key,
      required this.valueSetter,
      this.date,
      this.minDate,
      this.hideHour = false,
      required this.label});

  final ValueSetter<DateTime> valueSetter;
  final DateTime? date;
  final DateTime? minDate;
  final String label;
  final bool hideHour;

  @override
  FindDatePickerState createState() => FindDatePickerState();
}

class FindDatePickerState extends State<FindDatePicker> {
  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.date ?? DateTime.now();
  }

  Future<void> showTimerPicker() async {
    await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 220,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: Colors.white,
            padding: const EdgeInsets.only(top: 8.0),
            child: CupertinoDatePicker(
              initialDateTime: date,
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) {
                date = DateTime(date.year, date.month, date.day, newTime.hour,
                    newTime.minute);
                if (mounted) {
                  setState(() {});
                }
              },
            ),
          );
        });
  }

  Widget _buildAppBar() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        InkWell(onTap: Get.back, child: getSvgImage('ic_close')),
        Center(
          child: Text(
            'add_payment_title'.tr,
            style: tNormalTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            'hour'.tr,
            style: tNormalTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w600),
          )),
          InkWell(
            onTap: showTimerPicker,
            child: Container(
              padding: const EdgeInsets.all(kSmallPadding),
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(kSmallPadding)),
                  color: kDividerColor),
              child: Text(
                formatDateTime(
                    date: date, formatString: DateTimeFormatString.hhmm),
                style: tNormalTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: kSmallPadding),
          Text(
            '~',
            style: tNormalTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return SfDateRangePicker(
        todayHighlightColor: getColorPrimary(),
        view: DateRangePickerView.month,
        initialSelectedDate: date,
        showNavigationArrow: true,
        minDate: widget.minDate ?? DateTime.now().add(const Duration(days: 1)),
        onSelectionChanged: (dateRange) {
          final DateTime? dateArg = dateRange.value;
          if (dateArg != null) {
            date = DateTime(dateArg.year, dateArg.month, dateArg.day, date.hour,
                date.minute);
          }
        },
        headerStyle: DateRangePickerHeaderStyle(
            textStyle: tNormalTextStyle.copyWith(
                fontSize: 14, fontWeight: FontWeight.w600)),
        monthViewSettings: DateRangePickerMonthViewSettings(
            weekNumberStyle: DateRangePickerWeekNumberStyle(
                textStyle: tNormalTextStyle.copyWith(color: kBorderColor)),
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: tNormalTextStyle.copyWith(color: kBorderColor),
            )),
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: tNormalTextStyle.copyWith(fontSize: 14),
          todayTextStyle: tNormalTextStyle.copyWith(fontSize: 14),
        ),
        selectionTextStyle: tButtonWhiteTextStyle.copyWith(fontSize: 14),
        yearCellStyle: DateRangePickerYearCellStyle(
            textStyle: tNormalTextStyle.copyWith(fontSize: 14),
            disabledDatesTextStyle: tNormalTextStyle,
            todayTextStyle: tNormalTextStyle.copyWith(fontSize: 14),
            leadingDatesTextStyle: tNormalTextStyle),
        selectionMode: DateRangePickerSelectionMode.single);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: _buildAppBar(),
          ),
          const Divider(),
          _buildDatePicker(),
          if (!widget.hideHour) _buildTimePicker(),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: CustomButton(
                color: getColorPrimary(),
                borderColor: getColorPrimary(),
                onPressed: () async {
                  Get.back(closeOverlays: true);
                  widget.valueSetter(date);
                },
                widget: Text(
                  'select'.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w600),
                )),
          )
        ],
      ),
    );
  }
}
