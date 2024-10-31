import 'package:intl/intl.dart';

class DateFormater {
  static String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('MMMM d, y, h:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}
