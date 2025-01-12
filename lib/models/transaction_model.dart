class TrxItemModel {
  final String id;
  final int amount;
  final int totalAmount;
  final int kursAmount;
  final bool isIncome;
  final String note;
  final Map<String, dynamic> kursId;
  final Map<String, dynamic>? bankId;
  final Map<String, dynamic> typeId;
  final Map<String, dynamic> categoryId;
  final String datetime;

  const TrxItemModel({
    this.id = "",
    required this.amount,
    required this.totalAmount,
    required this.kursAmount,
    required this.isIncome,
    required this.note,
    required this.categoryId,
    required this.kursId,
    required this.bankId,
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
        isIncome: json["is_income"],
        typeId: json["type_id"],
        categoryId: json["category_id"],
        kursId: json["kurs_id"],
        bankId: json["bank_id"],
      );
}

class ListDataTransactionModel {
  final String id;
  final int totalMonthly;
  final List<TrxItemModel> items;

  const ListDataTransactionModel(
      {this.id = "", required this.totalMonthly, required this.items});

  factory ListDataTransactionModel.fromJson(Map<String, dynamic> json) =>
      ListDataTransactionModel(
        id: json['_id'],
        totalMonthly: json['total_monthly'],
        items: (json['items'] as List<dynamic>)
            .map((e) => TrxItemModel.fromJson(e))
            .toList(),
      );
}

class TransactionModel {
  final int grandTotal;
  final int currentMonthly;
  final List<ListDataTransactionModel> listData;

  TransactionModel(
      {required this.grandTotal,
      required this.currentMonthly,
      required this.listData});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      grandTotal: json['grand_total'],
      currentMonthly: json['current_monthly'],
      listData: (json['list_data'] as List<dynamic>)
          .map((e) => ListDataTransactionModel.fromJson(e))
          .toList(),
    );
  }
}
