class Gender {
  static const male = 'male';
  static const female = 'female';
}

class DateTimeFormatString {
  static const textBehind = 'textBehind';
  static const yyyyMMddhhMM = 'yyyy-MM-dd HH:mm';
  static const ddMMyyyy = 'dd/MM/yyyy';
  static const yyyyMMdd = 'yyyy-MM-dd';
  static const hhmm = 'HH:mm';
  static const mmddeeee = 'MM/dd (EEEEE)';
}

class CurrencySymbol {
  static const point = 'P';
}

class RouteId {
  static const search = 0;
  static const message = 1;
  static const call = 2;
  static const myPage = 3;
}

enum SendMessageType { text, image, video, join, create, leave, disband }

enum MessageGroupType { admin, group }
