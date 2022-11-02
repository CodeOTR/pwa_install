import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? getDateFromTimestamp(Timestamp? timestamp) {
  return timestamp?.toDate();
}

Timestamp? getTimestampFromDate(DateTime? dateTime) {
  return dateTime != null ? Timestamp.fromDate(dateTime) : null;
}

List<DateTime>? getDateListFromTimestampList(List<Timestamp>? timestamps) {
  return timestamps != null ? timestamps.map((e) => e.toDate()).toList() : null;
}

List<Timestamp>? getTimestampListFromDateList(List<DateTime>? dates) {
  return dates != null ? dates.map((e) => Timestamp.fromDate(e)).toList() : null;
}