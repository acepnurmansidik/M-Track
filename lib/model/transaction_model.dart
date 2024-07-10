import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String id;
  final int amount;
  final String note;
  final Map<String, dynamic> type_id;
  final Map<String, dynamic> category_id;

  const TransactionModel(
      {this.id = "",
      required this.amount,
      required this.note,
      required this.category_id,
      required this.type_id});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          id: json['_id'],
          amount: json['amount'],
          note: json['note'],
          type_id: json["type_id"],
          category_id: json["category_id"]);

  @override
  List<Object?> get props => [id, amount, note, category_id, type_id];
}
