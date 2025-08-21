import 'package:intl/intl.dart';

formatRupiah(int nominal) {
  return NumberFormat.currency(decimalDigits: 0, symbol: 'Rp. ')
      .format(nominal);
}

formatCurrency(int nominal) {
  return NumberFormat.currency(decimalDigits: 0, symbol: '', locale: "ID")
      .format(nominal);
}

toTitleCase(String input) {
  if (input.isEmpty) return input;

  return input.split(' ').map((word) {
    if (word.isEmpty) return word; // Menghindari kata kosong
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}
