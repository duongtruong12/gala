import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:get/get.dart';

class SelectMoodController extends GetxController {
  static SelectMoodController get to => Get.find();
  final listSituation = <String>[].obs;
  final listCastType = <String>[].obs;
  final selectedSituation = <String>[].obs;
  final selectedCastType = <String>[].obs;
  Rxn<bool> edit = Rxn<bool>();

  @override
  void onInit() {
    super.onInit();
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

  void onPressedBack() {
    Get.back(id: RouteId.call);
  }

  void onSelectSituation(str) {
    if (selectedSituation.contains(str)) {
      selectedSituation.remove(str);
    } else {
      selectedSituation.add(str);
    }
  }

  void onSelectCastType(str) {
    if (selectedCastType.contains(str)) {
      selectedCastType.remove(str);
    } else {
      selectedCastType.add(str);
    }
  }

  Future<void> switchFirstTimeUser() async {
    if (edit.value == true) {
      onPressedBack();
    } else {
      Get.toNamed(Routes.firstTimeUser, id: RouteId.call);
    }
  }

  void setEdit(bool edit) {
    this.edit.value = edit;
  }
}
