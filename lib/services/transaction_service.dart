import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/models/categories_model.dart';
import 'package:tracking/models/transaction_model.dart';

class TransactionService {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization':
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFjZXBudXJtYW5AZ21haWwuY29tIiwibmFtZSI6ImFjZXAgbnVybWFuIHNpZGlrIiwiaWF0IjoxNzU2MzQ5MDgyLCJleHAiOjE3NTY5NTM4ODIsImp0aSI6Ijg0MmIwNDM1ODdiNzQ3ZTU4N2Q0MWZjNDVlZDE4ZjgwIn0.UGlYvGqITyHN7n9hZvoV5Bd3IvsAc7bUFmx3WxHWpTz2aKEckUAwXvGgKHBCT_FL69Irwq7ASRH27W6DflLd_A",
  };
  Future<CategoriesModelProps> getCategories() async {
    try {
      final response = await http.get(
          Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/transaction/category'),
          headers: headers);

      final result = CategoriesModelProps.fromJson(json.decode(response.body));

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionModelProps> getTransactionList() async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/transaction/list'),
        headers: headers,
      );
      final result = TransactionModelProps.fromJson(json.decode(response.body));

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionPeriodeModelProps> getPeriodeTransaction() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${dotenv.env["PUBLIC_API_BASE_V1"]}/transaction/chart-category'),
        headers: headers,
      );
      final result =
          TransactionPeriodeModelProps.fromJson(json.decode(response.body));

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postTransaction(body) async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/transaction'),
        headers: headers,
        body: body,
      );

      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putTransaction(id, body) async {
    try {
      final response = await http.put(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/transaction/$id'),
        body: body,
        headers: headers,
      );
      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
