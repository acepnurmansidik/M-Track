class TransactionModelProps {
  bool status;
  String message;
  List<TransactionDaum> data;

  TransactionModelProps({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionModelProps.fromJson(Map<String, dynamic> json) {
    return TransactionModelProps(
      status: json["status"],
      message: json["message"],
      data: (json["data"] as List<dynamic>)
          .map((item) => TransactionDaum.fromJson(item))
          .toList(),
    );
  }
}

class TransactionDaum {
  String sId;
  int totalAmount;
  String note;
  String categoryName;
  String typeName;
  String createdAt;
  String date;
  int month;

  TransactionDaum({
    required this.sId,
    required this.totalAmount,
    required this.note,
    required this.categoryName,
    required this.typeName,
    required this.createdAt,
    required this.date,
    required this.month,
  });

  factory TransactionDaum.fromJson(Map<String, dynamic> json) {
    return TransactionDaum(
      sId: json['_id'],
      totalAmount: json['total_amount'],
      note: json['note'],
      categoryName: json['category_name'],
      typeName: json['type_name'],
      createdAt: json['createdAt'],
      date: json['date'],
      month: json['month'],
    );
  }
}
