import 'package:intl/intl.dart';

class DateFormatter {
  final DateTime lastUpdatedDate;

  DateFormatter({required this.lastUpdatedDate});

  String lastUpdatedDateText() {
    final formatter = DateFormat.yMd().add_Hms();
    final formattedDate = formatter.format(lastUpdatedDate);
    return 'Last updated: $formattedDate';
  }
}
