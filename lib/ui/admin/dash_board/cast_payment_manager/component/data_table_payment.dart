import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/model/transfer_request_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataTablePayment extends StatefulWidget {
  const DataTablePayment(
      {super.key,
      required this.list,
      required this.onCheckBox,
      this.onScrollDown,
      this.isEmpty = false});

  final List<TransferRequestModel> list;
  final bool isEmpty;
  final ValueChanged<int>? onScrollDown;
  final ValueChanged<List<TransferRequestModel>> onCheckBox;

  @override
  _DataTableTicket createState() => _DataTableTicket();
}

class _DataTableTicket extends State<DataTablePayment> {
  final _scrollController = ScrollController();
  int _page = 1;
  final map = <String?, TransferRequestModel>{};
  bool checkAll = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (widget.isEmpty) {
        return;
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        if (widget.onScrollDown != null) {
          widget.onScrollDown!(_page);
        }
      }
    });
  }

  DataColumn _buildItem(
      {required String label,
      double horizontal = 0,
      bool center = false,
      ColumnSize size = ColumnSize.M}) {
    final child = Padding(
      padding: EdgeInsets.only(left: horizontal),
      child: Text(
        label,
        style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w600),
      ),
    );
    return DataColumn2(
      label: center
          ? Center(
              child: child,
            )
          : child,
      size: size,
    );
  }

  bool checkAllContains() {
    for (var element in widget.list) {
      if (map[element.id] == null) {
        return false;
      }
    }
    return true;
  }

  List<DataColumn> get _columns {
    return [
      DataColumn2(
        label: Checkbox(
            value: checkAll,
            onChanged: (value) {
              map.clear();
              if (value == true) {
                for (var element in widget.list) {
                  map.putIfAbsent(element.id, () => element);
                }
              }
              checkAll = value!;
              widget.onCheckBox(map.values.toList());
              if (mounted) setState(() {});
            }),
        size: ColumnSize.S,
      ),
      _buildItem(label: 'request_date'.tr),
      _buildItem(label: 'transfer_status'.tr),
      _buildItem(label: 'transfer_information'.tr),
      _buildItem(label: 'account_type'.tr),
      _buildItem(label: 'branch_code'.tr),
      _buildItem(label: 'account_number'.tr),
      _buildItem(label: 'name_say'.tr),
      _buildItem(label: 'name_real'.tr),
      _buildItem(label: 'attendance_point'.tr),
    ];
  }

  DataCell _buildItemCellText(
      {required String? label, double paddingLeft = 0}) {
    return DataCell(Padding(
      padding: EdgeInsets.only(left: paddingLeft),
      child: Text(
        label ?? '',
        style: tNormalTextStyle.copyWith(fontSize: 12),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      return textEmpty();
    }
    return DataTable2(
      columns: _columns,
      scrollController: _scrollController,
      columnSpacing: 32,
      headingRowColor:
          MaterialStateColor.resolveWith((states) => kPrimaryColor),
      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
      rows: widget.list.map(
        (model) {
          return DataRow(
            cells: [
              DataCell(Checkbox(
                  value: map[model.id] != null,
                  onChanged: (value) {
                    if (model.id == null) return;
                    if (map[model.id] != null) {
                      map.remove(model.id);
                    } else {
                      map.putIfAbsent(model.id, () => model);
                    }
                    checkAll = checkAllContains();
                    widget.onCheckBox(map.values.toList());
                    if (mounted) setState(() {});
                  })),
              DataCell(getTransferRequestStatus(status: model.status)),
              _buildItemCellText(
                  label: formatDateTime(
                      date: model.createdDate,
                      formatString: DateTimeFormatString.yyyyMMdd)),
              _buildItemCellText(
                  label: model.transferInformationModel?.bankName),
              _buildItemCellText(
                  label: 'bank_${model.transferInformationModel?.bankType}'.tr),
              _buildItemCellText(
                  label: model.transferInformationModel?.branchCode),
              _buildItemCellText(
                  label: model.transferInformationModel?.bankNumber),
              _buildItemCellText(
                  label: model.transferInformationModel?.lastName),
              _buildItemCellText(
                  label: model.transferInformationModel?.firstName),
              _buildItemCellText(
                  label: formatCurrency(model.totalPrice,
                      symbol: CurrencySymbol.yen)),
            ],
          );
        },
      ).toList(),
    );
  }
}
