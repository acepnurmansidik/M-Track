class LoanModel {
  final String id;
  final String title;
  final bool statusPaid;
  final bool isIncome;
  final String fromName;
  final String toName;
  final String note;
  final String dueDate;
  final int nominal;
  final String? imageUrl;
  final String? createdAt;

  LoanModel({
    this.id = "",
    this.imageUrl = "",
    this.createdAt = "",
    required this.title,
    required this.statusPaid,
    required this.isIncome,
    required this.fromName,
    required this.toName,
    required this.note,
    required this.dueDate,
    required this.nominal,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['_id'],
      title: json['title'],
      statusPaid: json['status_paid'],
      isIncome: json['is_income'],
      fromName: json['from_name'],
      toName: json['to_name'],
      note: json['note'],
      dueDate: json['due_date'],
      createdAt: json['created_at'],
      nominal: json['nominal'],
      imageUrl: json['image_url'],
    );
  }
}
