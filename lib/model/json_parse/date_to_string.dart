import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? fromJsonDate(dynamic str) {
  return str == null || str == 'null' ? null : DateTime.parse('$str');
}

DateTime? fromJsonTimeStamp(dynamic str) {
  if (str == 'null') {
    return null;
  }
  if (str is Timestamp) {
    return str.toDate();
  }
  return null;
}
