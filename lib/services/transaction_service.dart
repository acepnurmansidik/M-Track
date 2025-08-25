import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/models/categories_model.dart';
import 'package:tracking/models/transaction_model.dart';

class TransactionService {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization':
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFjZXBudXJtYW5AZ21haWwuY29tIiwibmFtZSI6ImFjZXAgbnVybWFuIHNpZGlrIiwiaWF0IjoxNzU2MDMxMzk0LCJleHAiOjE3NTY2MzYxOTQsImp0aSI6Ijg0MmIwNDM1ODdiNzQ3ZTU4N2Q0MWZjNDVlZDE4ZjgwIn0.4cHBQmmq6Mdr3SGMQ_Q72cd48VbpxYW0mA6U99Fq4uPpW8sBbVKiHExtUQgEbiTKVWYkCvL3W1vL-Kk8zRuYwA",
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
}
