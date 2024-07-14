class TrxItem {
  final String id;
  final int amount;
  final String note;
  final Map<String, dynamic> typeId;
  final Map<String, dynamic> categoryId;
  final String datetime;

  const TrxItem({
    this.id = "",
    required this.amount,
    required this.note,
    required this.categoryId,
    required this.typeId,
    required this.datetime,
  });

  factory TrxItem.fromJson(Map<String, dynamic> json) => TrxItem(
        id: json['_id'],
        amount: json['amount'],
        note: json['note'],
        typeId: json["type_id"],
        categoryId: json["category_id"],
        datetime: json["datetime"],
      );
}

class TransactionModel {
  final String id;
  final List<TrxItem> items;

  const TransactionModel({this.id = "", required this.items});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['_id'],
        items: (json['items'] as List<dynamic>)
            .map((e) => TrxItem.fromJson(e))
            .toList(),
      );
}
