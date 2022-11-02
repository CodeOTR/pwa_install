import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Injectable service for Durations, DateTimes, and displaying formatted timestamps

class TimeService {
  MaterialLocalizations getLocalization(BuildContext context) {
    return MaterialLocalizations.of(context);
  }

  String getFormattedText(Duration duration) {
    return "${duration.inHours}:${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60))}";
  }

  DateTime getDateWithoutTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  String getTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  String getShortDateTime(DateTime? dateTime, BuildContext context) {
    if (dateTime != null) {
      return getLocalization(context).formatShortDate(dateTime);
    } else {
      return '';
    }
  }

  /// none: 15 minutes ago
  /// 'en_short' : 15m
  /// 'es': spanish
  String getFuzzyTime(DateTime dateTime, {String? locale}) {
    return timeago.format(dateTime, locale: locale);
  }

  String greetingText(TimeOfDay timeOfDay) {
    double nowTime = timeToDouble(TimeOfDay.now());
    double morningTime = timeToDouble(TimeOfDay(hour: 11, minute: 59));
    double afternoonTime = timeToDouble(TimeOfDay(hour: 4, minute: 59));
    double eveningTime = timeToDouble(TimeOfDay(hour: 23, minute: 59));

    if (nowTime < morningTime) {
      return 'Morning';
    } else if (nowTime < afternoonTime) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  double timeToDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
}
