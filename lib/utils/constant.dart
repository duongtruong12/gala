class DefaultFee {
  static const transfer = 654;
}

class Gender {
  static const male = 'male';
  static const female = 'female';
}

class DateTimeFormatString {
  static const textBehind = 'textBehind';
  static const textBehindHour = 'textBehindHour';
  static const textBehindddMM = 'textBehindddMM';
  static const yyyyMMddhhMM = 'yyyy-MM-dd HH:mm';
  static const ddMMyyyy = 'dd/MM/yyyy';
  static const yyyyMMdd = 'yyyy-MM-dd';
  static const hhmm = 'HH:mm';
  static const mmddeeee = 'MM/dd (EEEEE)';
}

class SharedPrefKey {
  static const femaleGender = 'femaleGender';
  static const user = 'user';
  static const password = 'password';
}

class CurrencySymbol {
  static const point = 'P';
  static const pointPerMinutes = 'pointPerMinutes';
  static const pointFull = 'ポイント';
  static const japan = '￥';
  static const yen = '円';
}

class RouteIdAdmin {
  static const casterManager = 8;
  static const guestManager = 9;
  static const chatManager = 10;
  static const paymentManager = 11;
  static const castPaymentManager = 12;
  static const callList = 13;
}

class RouteId {
  static const search = 0;
  static const message = 1;
  static const call = 2;
  static const myPage = 3;
}

class RouteIdFemale {
  static const search = 4;
  static const message = 5;
  static const call = 6;
  static const myPage = 7;
}

enum SendMessageType {
  text,
  image,
  video,
  join,
  create,
  pointCost,
  createTicket,
  leave,
  disband
}

enum MessageGroupType { admin, group }

enum PointReason { buy, gift, pay, remittancePayment }

enum TransferStatus {
  waiting,
  received,
  alreadyTransfer,
  cancel,
}

enum TypeAccount {
  admin,
  guest,
  caster,
}

enum StartTimeAfter {
  minutes30,
  minutes60,
  minutes90,
  customMinutes,
}

enum DurationDate {
  hour1,
  hour2,
  hour3,
  above4,
}

enum TicketStatus {
  created,
  done,
  finish,
  cancelled,
}
