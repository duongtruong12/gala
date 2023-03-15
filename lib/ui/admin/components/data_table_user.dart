import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DataColumnOrder {
  nickname,
  dateStatus,
  avatar,
  realName,
  email,
  birthDay,
  createdDate,
  point,
  status,
}

class DataTableUser extends StatefulWidget {
  const DataTableUser(
      {super.key,
      required this.list,
      this.isCaster = true,
      this.onScrollDown,
      this.isEmpty = false});

  final List<UserModel> list;
  final bool isCaster;
  final bool isEmpty;
  final ValueChanged<int>? onScrollDown;

  @override
  _DataTableUser createState() => _DataTableUser();
}

class _DataTableUser extends State<DataTableUser> {
  final _scrollController = ScrollController();
  final map = <int, bool>{
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
  };
  int _page = 1;

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

  void sort(
    int columnIndex,
    bool ascendingOrder,
  ) {
    if (map[columnIndex] == true) {
      switch (columnIndex) {
        case 0:
          widget.list.sort(
              (a, b) => a.displayName?.compareTo(b.displayName ?? '') ?? 0);
          break;
        case 1:
          widget.list.sort((a, b) => a.avatar?.compareTo(b.avatar ?? '') ?? 0);
          break;
        case 2:
          widget.list
              .sort((a, b) => a.realName?.compareTo(b.realName ?? '') ?? 0);
          break;
        case 3:
          widget.list.sort((a, b) => a.email?.compareTo(b.email ?? '') ?? 0);
          break;
        case 4:
          widget.list.sort((a, b) =>
              a.birthday?.compareTo(b.birthday ?? DateTime.now()) ?? 0);
          break;
        case 5:
          widget.list.sort((a, b) =>
              a.createdDate?.compareTo(b.createdDate ?? DateTime.now()) ?? 0);
          break;
        case 6:
          widget.list.sort(
              (a, b) => a.currentPoint?.compareTo(b.currentPoint ?? 0) ?? 0);
          break;
        default:
          break;
      }
    } else {
      switch (columnIndex) {
        case 0:
          widget.list.sort(
              (a, b) => b.displayName?.compareTo(a.displayName ?? '') ?? 0);
          break;
        case 1:
          widget.list.sort((a, b) => b.avatar?.compareTo(a.avatar ?? '') ?? 0);
          break;
        case 2:
          widget.list
              .sort((a, b) => b.realName?.compareTo(a.realName ?? '') ?? 0);
          break;
        case 3:
          widget.list.sort((a, b) => b.email?.compareTo(a.email ?? '') ?? 0);
          break;
        case 4:
          widget.list.sort((a, b) =>
              b.birthday?.compareTo(a.birthday ?? DateTime.now()) ?? 0);
          break;
        case 5:
          widget.list.sort((a, b) =>
              b.createdDate?.compareTo(a.createdDate ?? DateTime.now()) ?? 0);
          break;
        case 6:
          widget.list.sort(
              (a, b) => b.currentPoint?.compareTo(a.currentPoint ?? 0) ?? 0);
          break;
        default:
          break;
      }
    }
    map[columnIndex] = !(map[columnIndex] ?? false);
    if (mounted) setState(() {});
  }

  DataColumn _buildItem(
      {required String label,
      required DataColumnOrder order,
      double horizontal = 0,
      bool center = false,
      ColumnSize size = ColumnSize.M}) {
    final child = Padding(
      padding: EdgeInsets.only(left: horizontal),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: tNormalTextStyle.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
    return DataColumn2(
      label: center
          ? Center(
              child: child,
            )
          : child,
      size: size,
      onSort: (columnIndex, ascending) => sort(columnIndex, ascending),
    );
  }

  List<DataColumn> get _columns {
    return [
      _buildItem(
          label: 'nick_name'.tr,
          order: DataColumnOrder.nickname,
          size: ColumnSize.S),
      _buildItem(
          label: 'avatar'.tr,
          order: DataColumnOrder.nickname,
          horizontal: kDefaultPadding,
          center: true,
          size: ColumnSize.S),
      _buildItem(
          label: 'date_status'.tr,
          order: DataColumnOrder.dateStatus,
          horizontal: kDefaultPadding,
          center: true,
          size: ColumnSize.S),
      _buildItem(
          label: 'real_name'.tr,
          order: DataColumnOrder.realName,
          size: ColumnSize.S),
      _buildItem(
          label: 'email'.tr, order: DataColumnOrder.email, size: ColumnSize.L),
      _buildItem(label: 'birthday'.tr, order: DataColumnOrder.birthDay),
      _buildItem(label: 'created_date'.tr, order: DataColumnOrder.createdDate),
      _buildItem(
          label: 'point'.tr, order: DataColumnOrder.point, size: ColumnSize.S),
      _buildItem(
        label: 'status'.tr,
        order: DataColumnOrder.status,
        size: ColumnSize.S,
        center: true,
        horizontal: kDefaultPadding,
      ),
    ];
  }

  DataCell _buildDateStatusItem({required UserModel model}) {
    return DataCell(
      Builder(builder: (context) {
        bool notInDate = model.approveTickets.isEmpty;
        if (notInDate) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.all(kSmallPadding),
          child: CustomButton(
            onPressed: () async {
              String? id;
              if (widget.isCaster) {
                id = model.approveTickets.first;
                final messageModelGroup =
                    await fireStoreProvider.getMessageGroupByTicketId(
                        ticketId: id, source: Source.cache);
                if (messageModelGroup != null) {
                  await Get.toNamed(Routes.messageDetail,
                      arguments: true,
                      parameters: {'id': messageModelGroup.id!});
                }
              }
            },
            borderColor: kStatusRed,
            color: kStatusRed,
            borderRadius: kDefaultPadding,
            widget: Text(
              'in_date'.tr,
              style: tButtonWhiteTextStyle.copyWith(fontSize: 12),
            ),
          ),
        );
      }),
    );
  }

  DataCell _buildItemCellText({required String? label}) {
    return DataCell(Text(
      label ?? '',
      style: tNormalTextStyle.copyWith(fontSize: 12),
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
      headingRowColor: MaterialStateColor.resolveWith(
          (states) => widget.isCaster ? kPrimaryColorFemale : kPrimaryColor),
      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
      sortAscending: false,
      rows: widget.list
          .map(
            (model) => DataRow(
              cells: [
                _buildItemCellText(label: model.displayName),
                DataCell(
                  Center(
                    child: SizedBox(
                      height: 36,
                      width: 36,
                      child: CustomCircleImage(
                        radius: 99,
                        image: CustomNetworkImage(
                          url: model.avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                _buildDateStatusItem(model: model),
                _buildItemCellText(label: model.realName),
                _buildItemCellText(label: model.email),
                _buildItemCellText(
                    label: formatDateTime(
                        date: model.birthday,
                        formatString: DateTimeFormatString.textBehind)),
                _buildItemCellText(
                    label: formatDateTime(
                        date: model.createdDate,
                        formatString: DateTimeFormatString.textBehind)),
                _buildItemCellText(label: formatCurrency(model.currentPoint)),
                DataCell(
                  Padding(
                    padding: const EdgeInsets.all(kSmallPadding),
                    child: CustomButton(
                      onPressed: () async {
                        Get.toNamed(Routes.userDetail,
                            parameters: {'id': '${model.id}'}, arguments: true);
                      },
                      borderColor: kTextColorDark,
                      color: Colors.white,
                      borderRadius: kDefaultPadding,
                      widget: Text(
                        'valid'.tr,
                        style: tNormalTextStyle.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
