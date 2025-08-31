import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/models/categories_model.dart';
import 'package:tracking/models/transaction_model.dart';
import 'package:tracking/services/auth_service.dart';

class TransactionService {
  Future<CategoriesModelProps> getCategories() async {
    try {
      final headers = await AuthService().authTokenHeaders('json');
      final response = await http.get(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/transaction/category'),
        headers: headers,
      );

      final result = CategoriesModelProps.fromJson(json.decode(response.body));

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionModelProps> getTransactionList() async {
    try {
      final headers = await AuthService().authTokenHeaders('json');
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
      final headers = await AuthService().authTokenHeaders('json');
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
      final headers = await AuthService().authTokenHeaders('json');
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
      final headers = await AuthService().authTokenHeaders('json');
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
