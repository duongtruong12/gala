import 'dart:collection';
import 'dart:ui';

import 'package:get/get.dart';

import 'text/st_ja_jp.dart';

class LocalizationService extends Translations {
// locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage();

// fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static const fallbackLocale = Locale('ja', 'ja_JP');

// language code của những locale được support
  static final langCodes = [
    'ja',
  ];

// các Locale được support
  static final locales = [
    const Locale('ja', 'ja_JP'),
  ];

// cái này là Map các language được support đi kèm với mã code của lang đó: cái này dùng để đổ data vào Dropdownbutton và set language mà không cần quan tâm tới language của hệ thống
  static final langs = LinkedHashMap.from({
    'ja': 'Japanese',
  });

// function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'ja_JP': ja,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = 'ja';
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale ?? fallbackLocale;
  }
}
