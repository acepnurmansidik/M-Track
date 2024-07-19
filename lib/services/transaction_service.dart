import 'dart:convert';
import 'dart:io';

import 'package:tracking/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<TransactionModel> getTransactions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/trx'));
      final Map<String, dynamic> data = json.decode(response.body);

      TransactionModel transactions = TransactionModel.fromJson(data["data"]);

      return transactions;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTrx(body) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/trx'), body: body);
      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTrx(String id, Map<String, dynamic> body) async {
    try {
      final response =
          await http.put(Uri.parse('$baseUrl/trx/$id'), body: body);
      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> destroyTrx(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/trx/$id'));
      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}