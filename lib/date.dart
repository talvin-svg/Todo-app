import 'package:intl/intl.dart';

final millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

final format = DateFormat('EEEE d' + "'" + ' of ' 'MMMM y');
final formattedDateTime = format.format(dateTime);
