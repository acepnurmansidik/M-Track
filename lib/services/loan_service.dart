import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/models/loan_model.dart';
import 'package:tracking/services/auth_service.dart';
import 'package:http/http.dart' as http;

class LoanService {
  final url = "${dotenv.env["PUBLIC_API_BASE_V1"]}/loan/";
  Future<List<dynamic>> fetchLoanIndex() async {
    try {
      // get header di auth
      final headers = await AuthService().authTokenHeaders('json');

      // get data
      final response = await http.get(Uri.parse(url), headers: headers);

      // parsing response ke dalma model
      final result = json
          .decode(response.body)["data"]
          .map((item) => LoanModel.fromJson(item))
          .toList();

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createNewLoan(body) async {
    try {
      // get header di auth
      final headers = await AuthService().authTokenHeaders('json');

      // post data ke BE
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      // cek jika ada error
      if (json.decode(response.body)["code"] >= 400) {
        throw HttpException(json.decode(response.body)["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateNewLoan(body, String id) async {
    try {
      // get header di auth
      final headers = await AuthService().authTokenHeaders('json');

      // post data ke BE
      final response =
          await http.put(Uri.parse(url + id), headers: headers, body: body);
      // cek jika ada error
      if (json.decode(response.body)["code"] >= 400) {
        throw HttpException(json.decode(response.body)["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
