import 'dart:convert';

import 'package:tracking/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<List<dynamic>> getTransactions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/trx'));
      final data = json.decode(response.body);

      List<dynamic> transactions =
          data["data"].map((item) => TransactionModel.fromJson(item)).toList();

      return transactions;
    } catch (e) {
      rethrow;
    }
  }
}
