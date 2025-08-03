import 'package:intl/intl.dart';

formatRupiah(int nominal) {
  return NumberFormat.currency(decimalDigits: 0, symbol: 'Rp. ')
      .format(nominal);
}
