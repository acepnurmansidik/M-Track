class TransactionModel {
  final String id;
  final int amount;
  final String note;
  final Map<String, dynamic> typeId;
  final Map<String, dynamic> categoryId;

  const TransactionModel(
      {this.id = "",
      required this.amount,
      required this.note,
      required this.categoryId,
      required this.typeId});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          id: json['_id'],
          amount: json['amount'],
          note: json['note'],
          typeId: json["type_id"],
          categoryId: json["category_id"]);
}