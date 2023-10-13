import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime inputDate) {
    return year == inputDate.year &&
        month == inputDate.month &&
        day == inputDate.day;
  }
}

class DateUtil {
  static DateTime tomorrow() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + 1);
  }

  static String hMMFormat(DateTime dateTime) {
    return DateFormat('H:mm').format(dateTime);
  }

  static String dateWithDayFormat(DateTime dateTime) {
    final weekName = _weekNames()[dateTime.weekday];
    final date = DateFormat('M/d').format(dateTime);

    return '$date ($weekName)';
  }

  static List<String> _weekNames() {
    return <String>[
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
  }
}
