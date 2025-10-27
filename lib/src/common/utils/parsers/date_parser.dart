import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppUtils {
  static MaskTextInputFormatter phoneMaskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );
  static MaskTextInputFormatter textMaskFormatter = MaskTextInputFormatter();

  static MaskTextInputFormatter codeMaskFormatter = MaskTextInputFormatter(
    mask: '######',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static MaskTextInputFormatter dateMaskFormatter = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static NumberFormat costFormat = NumberFormat("#,##0", "ru_RU");

  static MaskTextInputFormatter timeMaskFormatter = MaskTextInputFormatter(
    mask: '##:##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static MaskTextInputFormatter amountMaskFormatter = MaskTextInputFormatter(
    mask: '₸ ##########',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static String? phoneValidation(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.length < 11) {
      return 'Введите корректный номер телефона';
    } else {
      return null;
    }
  }

  static String? textValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите корректный текст';
    } else {
      return null;
    }
  }

  static String getFormattedDate(String date) {
    var localDate = DateTime.parse(date);

    var inputFormat = DateFormat('dd.MM.yyyy');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  static String getServerDate(String date) {
    DateFormat originalFormat = DateFormat('dd.MM.yyyy');
    DateTime dateTime = originalFormat.parse(date);

    DateFormat newFormat = DateFormat('yyyy-MM-dd');

    return newFormat.format(dateTime);
  }

  static String? emailValidate(String? value) {
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || !regExp.hasMatch(value)) {
      return 'Введите корректный e-mail';
    } else {
      return null;
    }
  }

  static String formatPrice(dynamic price, {String? currency}) {
    if (price == null) return '';
    return '$price ${currency ?? 'KZT'}';
  }
}
