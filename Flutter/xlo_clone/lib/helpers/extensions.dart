import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isEmailValid() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}

extension NumberExtension on double {
  String formattedMoney() {
    return NumberFormat('R\$###,###0.00', 'PT-br').format(this);
  }
}

extension DateTimeExtension on DateTime {
  String formattedDate() {
    return DateFormat('dd/MM/yyyy hh:mm', 'pt-BR').format(this);
  }
}
