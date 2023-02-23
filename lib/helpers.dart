import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getDayOfTheWeek() {
  return weeks[DateTime.now().weekday - 1];
}

final weeks = [
  'Monday',
  ' Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

String getCurrentDate() {
  return DateFormat('LLLL dd, yyyy').format(DateTime.now());
}

bool isMorning() {
  final now = TimeOfDay.now();
  const morningThreshold = TimeOfDay(hour: 12, minute: 0);
  return now.hour < morningThreshold.hour;
}
