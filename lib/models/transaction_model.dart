class TransactionDaum {
  String sId;
  bool isPaid;
  int totalAmount;
  String note;
  String categoryName;
  String typeName;
  String createdAt;
  String date;
  int month;

  TransactionDaum({
    required this.sId,
    required this.isPaid,
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
      isPaid: json['is_paid'],
      note: json['note'],
      categoryName: json['category_name'],
      typeName: json['type_name'],
      createdAt: json['createdAt'],
      date: json['date'],
      month: json['month'],
    );
  }
}

class TransactionModelProps {
  bool success;
  String message;
  List<TransactionDaum> data;

  TransactionModelProps({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TransactionModelProps.fromJson(Map<String, dynamic> json) {
    return TransactionModelProps(
      success: json["success"],
      message: json["message"],
      data: (json["data"] as List<dynamic>)
          .map((item) => TransactionDaum.fromJson(item))
          .toList(),
    );
  }
}

class TransactionPeriodeModelProps {
  bool success;
  String message;
  List<PeriodeProp> data;

  TransactionPeriodeModelProps({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TransactionPeriodeModelProps.fromJson(Map<String, dynamic> json) {
    return TransactionPeriodeModelProps(
      success: json["success"],
      message: json["message"],
      data: (json["data"] as List<dynamic>)
          .map((item) => PeriodeProp.fromJson(item))
          .toList(),
    );
  }
}

class PeriodeProp {
  String periode;
  int income;
  int expense;
  int totalCategory;
  List<TransactionDaum> listData;

  PeriodeProp({
    required this.periode,
    required this.income,
    required this.expense,
    required this.listData,
    required this.totalCategory,
  });

  factory PeriodeProp.fromJson(Map<String, dynamic> json) {
    return PeriodeProp(
      periode: json["periode"],
      income: json["income"],
      expense: json["expense"],
      totalCategory: json["total_category"],
      listData: (json["list_data"] as List<dynamic>)
          .map((item) => TransactionDaum.fromJson(item))
          .toList(),
    );
  }
}
