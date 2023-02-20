import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/components/chip_item_select.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectTag extends StatefulWidget {
  const SelectTag({Key? key, this.initList, required this.valueSetter})
      : super(key: key);

  final List? initList;
  final ValueSetter<List> valueSetter;

  @override
  _SelectTag createState() => _SelectTag();
}

class _SelectTag extends State<SelectTag> {
  final listSituation = [];
  final listCastType = [];
  final selectList = [];

  @override
  void initState() {
    super.initState();
    if (widget.initList != null) {
      selectList.addAll(widget.initList!);
    }
    _installList();
  }

  Future<void> _installList() async {
    listSituation.addAll([
      'プライベート',
      '対話',
      '飲める人',
      'わいわい',
      'しっとり',
      'カラオケ',
      '酔いの向こう側まで',
      '朝までOK',
      '英語できる子歓迎',
      'タバコNG',
      'マナー重視',
    ]);
    listCastType.addAll([
      '可愛い系',
      '綺麗系',
      '清楚系',
      'アイドル系',
      'お姉さん系',
      'お嬢様系',
      'ロリ系',
      'ギャル系',
      'ハーフ系',
      '小柄(150以下)',
      '普通(151〜160)',
      '高身長(161以上)',
      '20代前半',
      '20代中盤',
      '20代後半',
      '30代',
      '映画',
      '中国語',
      '接待上手',
      'ゴルフ',
      'スレンダー',
      'グラマー',
      'ハーフ / ハーフ顔',
      'セクシー',
      '童顔',
      '学生',
      'OL',
      'モデル',
      'アイドル',
      '女優',
      '看護師',
      '保育士',
      '美容師',
      '歌手',
    ]);
  }

  void onSelectSituation(str) {
    if (selectList.contains(str)) {
      selectList.remove(str);
    } else {
      selectList.add(str);
    }
    if (mounted) setState(() {});
  }

  Widget _buildWrapSituation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: listSituation
              .map((e) => ChipItemSelect(
                    value: e,
                    label: e,
                    isSelect: selectList.contains(e),
                    onPress: onSelectSituation,
                  ))
              .toList()),
    );
  }

  Widget _buildWrapCastType() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: listCastType
              .map((e) => ChipItemSelect(
                    value: e,
                    label: e,
                    isSelect: selectList.contains(e),
                    onPress: onSelectSituation,
                  ))
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'situation'.tr,
          style: tButtonWhiteTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: getTextColorSecond()),
        ),
        _buildWrapSituation(),
        const SizedBox(height: kDefaultPadding),
        Text(
          'cast_type'.tr,
          style: tButtonWhiteTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: getTextColorSecond()),
        ),
        _buildWrapCastType(),
        const SizedBox(height: kDefaultPadding),
        CustomButton(
            onPressed: () async {
              widget.valueSetter(selectList);
            },
            borderRadius: 4,
            widget: Text(
              'call_cast'.tr,
              style: tNormalTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            )),
      ],
    );
  }
}
