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
