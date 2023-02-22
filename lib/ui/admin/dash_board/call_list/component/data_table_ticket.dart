import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataTableTicket extends StatefulWidget {
  const DataTableTicket(
      {super.key,
      required this.list,
      required this.onTapTicket,
      this.onScrollDown,
      this.isEmpty = false});

  final List<Ticket> list;
  final bool isEmpty;
  final ValueChanged<int>? onScrollDown;
  final ValueSetter<Ticket> onTapTicket;

  @override
  _DataTableTicket createState() => _DataTableTicket();
}

class _DataTableTicket extends State<DataTableTicket> {
  final _scrollController = ScrollController();
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

  List<DataColumn> get _columns {
    return [
      _buildItem(label: 'nick_name'.tr, size: ColumnSize.S),
      _buildItem(label: 'avatar'.tr, center: true, size: ColumnSize.S),
      _buildItem(label: 'meeting_place'.tr),
      _buildItem(label: 'number_people'.tr, size: ColumnSize.S),
      _buildItem(label: 'start_time'.tr),
      _buildItem(label: 'required_time'.tr),
      _buildItem(
        label: 'detail'.tr,
        center: true,
        horizontal: kDefaultPadding,
      ),
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
      rows: widget.list
          .map(
            (model) => DataRow(
              cells: [
                DataCell(FutureBuilder<UserModel?>(
                    future: fireStoreProvider.getUserDetail(
                        id: model.createdUser, source: Source.cache),
                    builder: (BuildContext context,
                        AsyncSnapshot<UserModel?> snapshot) {
                      return Text(
                        snapshot.data?.displayName ?? '',
                        style: tNormalTextStyle.copyWith(fontSize: 12),
                      );
                    })),
                DataCell(
                  FutureBuilder<UserModel?>(
                      future: fireStoreProvider.getUserDetail(
                          id: model.createdUser),
                      builder: (BuildContext context,
                          AsyncSnapshot<UserModel?> snapshot) {
                        return Center(
                          child: SizedBox(
                            height: 36,
                            width: 36,
                            child: CustomCircleImage(
                              radius: 99,
                              image: CustomNetworkImage(
                                url: snapshot.data?.avatar,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                _buildItemCellText(
                    label: '${model.cityName} ${model.stateName}'),
                _buildItemCellText(
                    label: '${model.numberPeople}', paddingLeft: kSmallPadding),
                _buildItemCellText(
                    label: formatDateTime(
                        date: model.startTime,
                        formatString: DateTimeFormatString.textBehindHour)),
                _buildItemCellText(label: model.durationDate?.tr),
                DataCell(
                  Padding(
                    padding: const EdgeInsets.all(kSmallPadding),
                    child: CustomButton(
                      onPressed: () async {
                        widget.onTapTicket(model);
                      },
                      borderColor: kTextColorDark,
                      color: Colors.white,
                      borderRadius: kDefaultPadding,
                      widget: Text(
                        'detail'.tr,
                        style: tNormalTextStyle,
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
