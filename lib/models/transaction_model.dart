class TrxItemModel {
  final String id;
  final int amount;
  final int totalAmount;
  final int kursAmount;
  final String note;
  final Map<String, dynamic> kursId;
  final Map<String, dynamic> typeId;
  final Map<String, dynamic> categoryId;
  final String datetime;

  const TrxItemModel({
    this.id = "",
    required this.amount,
    required this.totalAmount,
    required this.kursAmount,
    required this.note,
    required this.categoryId,
    required this.kursId,
    required this.typeId,
    required this.datetime,
  });

  factory TrxItemModel.fromJson(Map<String, dynamic> json) => TrxItemModel(
        id: json['_id'],
        amount: json['amount'],
        totalAmount: json['total_amount'],
        kursAmount: json['kurs_amount'],
        note: json['note'],
        datetime: json["datetime"],
        typeId: json["type_id"],
        categoryId: json["category_id"],
        kursId: json["kurs_id"],
      );
}

class TransactionModel {
  final String id;
  final int totalMonthly;
  final List<TrxItemModel> items;

  const TransactionModel(
      {this.id = "", required this.totalMonthly, required this.items});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['_id'],
        totalMonthly: json['total_monthly'],
        items: (json['items'] as List<dynamic>)
            .map((e) => TrxItemModel.fromJson(e))
            .toList(),
      );
}
