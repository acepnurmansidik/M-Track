import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/services/auth_service.dart';

class TransactionService {
  Future<TransactionModel> getTransactions() async {
    try {
      final header = await AuthService().authTokenHeaders('json');
      final response = await http.get(
          Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/trx'),
          headers: header);

      final Map<String, dynamic> data = json.decode(response.body);
      TransactionModel transactions = TransactionModel.fromJson(data["data"]);

      return transactions;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTrx(body) async {
    try {
      final header = await AuthService().authTokenHeaders('json');
      final response = await http.post(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/trx'),
        body: body,
        headers: header,
      );
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
      final header = await AuthService().authTokenHeaders('json');
      final response = await http.put(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/trx/$id'),
        body: body,
        headers: header,
      );
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
      final header = await AuthService().authTokenHeaders('json');
      final response = await http.delete(
          Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/trx/$id'),
          headers: header);
      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
