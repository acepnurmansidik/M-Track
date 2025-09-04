// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:intl/intl.dart';

formatRupiah(int nominal) {
  return NumberFormat.currency(decimalDigits: 0, symbol: 'Rp. ')
      .format(nominal);
}

formatCurrency(dynamic nominal) {
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

String truncateWithEllipsis({String text = '', int cutoff = 10}) {
  if (text.length <= cutoff) {
    return text;
  } else {
    return text.substring(0, cutoff) + '...';
  }
}

String formatEmptyProfile(String title) {
  // Memisahkan nama menjadi bagian-bagian
  List<String> nameParts = title.split(" ");

  // Mengambil inisial berdasarkan jumlah bagian nama
  String initials;
  if (nameParts.length >= 2) {
    // Jika ada lebih dari satu bagian, ambil inisial dari dua bagian pertama
    initials = nameParts[0][0] + nameParts[1][0];
  } else if (nameParts.isNotEmpty) {
    // Jika hanya ada satu bagian, ambil dua karakter pertama
    initials =
        nameParts[0].length > 1 ? nameParts[0].substring(0, 2) : nameParts[0];
  } else {
    // Jika tidak ada nama, kembalikan string kosong
    initials = '';
  }

  // Mengembalikan inisial dalam huruf kapital
  return initials.toUpperCase();
}

String formatCurrencyIDRNumberShort(num value) {
  if (value >= 1000000000000) {
    return '${(value / 1000000000000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), '')}T'; // T untuk triliun
  } else if (value >= 1000000000) {
    return '${(value / 1000000000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), '')}M'; // M untuk milyar
  } else if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), '')}jt'; // jt untuk juta
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), '')}rb'; // rb untuk ribu
  } else {
    return value.toStringAsFixed(0);
  }
}
