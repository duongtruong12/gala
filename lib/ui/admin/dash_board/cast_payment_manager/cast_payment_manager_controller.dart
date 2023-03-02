import 'dart:async';
import 'dart:convert';

//ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:base_flutter/model/transfer_request_model.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call_female/components/find_date_picker.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class CastPaymentManagerController extends GetxController {
  static CastPaymentManagerController get to => Get.find();
  final searchController = TextEditingController();
  final transferStatus = Rxn<String>();
  final changeStatus = Rxn<String>();
  final minDate = Rxn<DateTime>();
  final maxDate = Rxn<DateTime>();
  final listTransferStatus = [
    TransferStatus.waiting.name,
    TransferStatus.received.name,
    TransferStatus.alreadyTransfer.name,
    TransferStatus.cancel.name,
  ];

  final list = <TransferRequestModel>[].obs;
  final listBase = <TransferRequestModel>[].obs;
  final listSelect = <String?>[];
  int page = 1;
  StreamSubscription? streamSubscription;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  bool checkEmpty() {
    return list.length > page * kPagingSize;
  }

  Future<void> getData() async {
    streamSubscription?.cancel();
    streamSubscription = fireStoreProvider.listenerTransferRequest(
        status: transferStatus.value,
        page: page,
        minDate: minDate.value,
        maxDate: maxDate.value,
        valueChanged: (listDoc) {
          list.clear();
          listBase.clear();
          if (listDoc.docs.isNotEmpty) {
            for (var value in listDoc.docs) {
              try {
                final messageModel =
                    TransferRequestModel.fromJson(value.data());
                listBase.add(messageModel);
              } catch (e) {
                logger.e(e);
              }
            }
            list.addAll(listBase);
          }

          list.sort((a, b) =>
              a.createdDate?.millisecondsSinceEpoch
                  .compareTo(b.createdDate?.millisecondsSinceEpoch ?? 0) ??
              0);

          list.refresh();
        });
  }

  Future<void> onScrollDown(int index) async {
    page = index;
    await getData();
  }

  Future<void> onRefresh() async {
    page = 1;
    await getData();
  }

  Future<void> onTapChangeStatus() async {
    if (this.listSelect.isEmpty || changeStatus.value == null) return;
    final listSelect =
        list.where((p0) => this.listSelect.contains(p0.id)).toList();

    await fireStoreProvider.changeStatusListTransfer(
        status: changeStatus.value!, list: listSelect);
  }

  void onChangeTransferStatus(dynamic str) {
    transferStatus.value = str;
    onRefresh();
  }

  void onChangeChangeStatus(dynamic str) {
    changeStatus.value = str;
  }

  Future<void> exportExcel() async {
    if (this.listSelect.isEmpty) return;

    final listSelect =
        list.where((p0) => this.listSelect.contains(p0.id)).toList();

    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1:I1').columnWidth = 16.5;
    sheet.getRangeByName('A1:I1').cellStyle.backColor = '#BCA674';
    sheet.getRangeByName('A1:I1').cellStyle.fontColor = '#2F2F2F';

    sheet.getRangeByName('A1').setText('request_date'.tr);
    sheet.getRangeByName('B1').setText('transfer_status'.tr);
    sheet.getRangeByName('C1').setText('transfer_information'.tr);
    sheet.getRangeByName('D1').setText('account_type'.tr);
    sheet.getRangeByName('E1').setText('branch_code'.tr);
    sheet.getRangeByName('F1').setText('account_number'.tr);
    sheet.getRangeByName('G1').setText('name_say'.tr);
    sheet.getRangeByName('H1').setText('name_real'.tr);
    sheet.getRangeByName('I1').setText('attendance_point'.tr);

    for (int i = 0; i < listSelect.length; i++) {
      final index = i + 2;
      final model = listSelect[i];
      sheet.getRangeByName('A$index').setText(formatDateTime(
          date: model.createdDate,
          formatString: DateTimeFormatString.yyyyMMdd));
      sheet
          .getRangeByName('B$index')
          .setText('transfer_status_${model.status}'.tr);
      sheet
          .getRangeByName('C$index')
          .setText(model.transferInformationModel?.bankName);
      sheet
          .getRangeByName('D$index')
          .setText('bank_${model.transferInformationModel?.bankType}'.tr);
      sheet
          .getRangeByName('E$index')
          .setText('${model.transferInformationModel?.branchCode}');
      sheet
          .getRangeByName('F$index')
          .setText('${model.transferInformationModel?.bankNumber}');
      sheet
          .getRangeByName('G$index')
          .setText(model.transferInformationModel?.lastName);
      sheet
          .getRangeByName('H$index')
          .setText(model.transferInformationModel?.firstName);
      sheet.getRangeByName('I$index').setText(
          formatCurrency(model.totalPrice, symbol: CurrencySymbol.yen));
    }

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

// Save the Excel file in the local machine.
    await saveAndLaunchFile(bytes,
        '${formatDateTime(date: DateTime.now(), formatString: DateTimeFormatString.textBehindddMM)}.xlsx');
  }

  ///To save the Excel file in the device
  ///To save the Excel file in the device
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', fileName)
      ..click();
  }

  Future<void> selectDate(bool isMinDate) async {
    await showCustomDialog(
      widget: SizedBox(
        width: Get.width * 0.7,
        child: FindDatePicker(
          hideHour: true,
          minDate: DateTime.fromMillisecondsSinceEpoch(0),
          date: isMinDate ? minDate.value : maxDate.value,
          valueSetter: (DateTime value) {
            if (isMinDate) {
              minDate.value = value;
            } else {
              maxDate.value = value;
            }
            if (minDate.value != null &&
                maxDate.value != null &&
                maxDate.value!.isBefore(minDate.value!)) {
              minDate.value = maxDate.value;
            }
            onRefresh();
          },
          label: isMinDate ? 'min_date'.tr : 'max_date'.tr,
        ),
      ),
    );
  }

  void onChanged(String str) {
    list.clear();
    if (str.isNotEmpty != true) {
      list.addAll(listBase);
      return;
    }

    list.addAll(listBase.where((e) {
      return formatDateTime(
                  date: e.createdDate,
                  formatString: DateTimeFormatString.yyyyMMdd)
              .contains(str) ||
          'transfer_status_${e.status}'.tr.contains(str) ||
          '${e.transferInformationModel?.bankName}'.contains(str) ||
          'bank_${e.transferInformationModel?.bankType}'.tr.contains(str) ||
          '${e.transferInformationModel?.branchCode}'.contains(str) ||
          '${e.transferInformationModel?.bankNumber}'.contains(str) ||
          '${e.transferInformationModel?.lastName}'.contains(str) ||
          '${e.transferInformationModel?.firstName}'.contains(str) ||
          formatCurrency(e.totalPrice, symbol: CurrencySymbol.yen)
              .contains(str);
    }));
  }

  void onCheckBox(List<TransferRequestModel> list) {
    listSelect.clear();
    for (var element in list) {
      listSelect.add(element.id);
    }
  }
}
