import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FindDatePicker extends StatefulWidget {
  const FindDatePicker({super.key});

  @override
  FindDatePickerState createState() => FindDatePickerState();
}

class FindDatePickerState extends State<FindDatePicker> {
  DateTime hour = DateTime.now();

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
              initialDateTime: hour,
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) {
                if (mounted) {
                  setState(() {
                    hour = newTime;
                  });
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
                    date: hour, formatString: DateTimeFormatString.hhmm),
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
        todayHighlightColor: kPrimaryColorFemale,
        view: DateRangePickerView.month,
        showNavigationArrow: true,
        headerStyle: DateRangePickerHeaderStyle(
            textStyle: tNormalTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600)),
        monthViewSettings: DateRangePickerMonthViewSettings(
            weekNumberStyle: DateRangePickerWeekNumberStyle(
                textStyle: tNormalTextStyle.copyWith(color: kBorderColor)),
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: tNormalTextStyle.copyWith(color: kBorderColor),
            )),
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: tNormalTextStyle.copyWith(fontSize: 18),
          todayTextStyle: tNormalTextStyle.copyWith(fontSize: 18),
        ),
        selectionTextStyle: tButtonWhiteTextStyle.copyWith(fontSize: 18),
        yearCellStyle: DateRangePickerYearCellStyle(
            textStyle: tNormalTextStyle.copyWith(fontSize: 18),
            disabledDatesTextStyle: tNormalTextStyle,
            todayTextStyle: tNormalTextStyle.copyWith(fontSize: 18),
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
          _buildTimePicker(),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: CustomButton(
                onPressed: () async {
                  Get.back(closeOverlays: true);
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
