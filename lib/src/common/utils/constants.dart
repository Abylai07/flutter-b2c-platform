import 'package:intl/intl.dart';

const kAppBarDateFormat = 'M/yyyy';
const kMonthFormat = 'MMMM';
const kMonthFormatWidthYear = 'MMMM yyyy';
const kDateRangeFormat = 'dd-MM-yy';

List<String> allowFileTypes = ['pdf', 'doc', 'docx', 'xls', 'xlsb', 'xlsm', 'xlsx'];

List<String> monthsInRussian = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь',
];

String getCurrentDate() {
  final now = DateTime.now();
  final dateFormat = DateFormat('EEEE, d MMMM', 'ru');
  final formattedDate = dateFormat.format(now);
  return formattedDate;
}

String getRussianDate(DateTime date) {
  final dateFormat = DateFormat('d MMMM yyyy', 'ru');
  final formattedDate = dateFormat.format(date);
  return formattedDate;
}


String getRussianDateDay(DateTime date) {
  final dateFormat = DateFormat('d MMMM, EEEE', 'ru');
  final formattedDate = dateFormat.format(date);
  return formattedDate;
}
