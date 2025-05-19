import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  // Format as yyyy-MM-dd
  String toSimpleDateString() {
    return '${this.year.toString().padLeft(4, '0')}-'
        '${this.month.toString().padLeft(2, '0')}-'
        '${this.day.toString().padLeft(2, '0')}';
  }

  // Format as hh:mm AM/PM
  String to12HourTimeString() {
    final hour12 = this.hour % 12 == 0 ? 12 : this.hour % 12;
    final amPm = this.hour >= 12 ? 'PM' : 'AM';
    return '${hour12.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')} $amPm';
  }

  // Check if the DateTime is today
  bool isToday() {
    final now = DateTime.now();
    return this.year == now.year &&
        this.month == now.month &&
        this.day == now.day;
  }

  // Add days (optional utility)
  DateTime addDays(int days) => this.add(Duration(days: days));

  String toFriendlyDateString() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(year, month, day);

    final difference = today.difference(dateToCheck).inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    } else {
      return DateFormat('d MMM yyyy').format(this); // e.g. 15 May 2025
    }
  }
}
