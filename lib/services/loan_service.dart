import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/models/loan_model.dart';
import 'package:tracking/services/auth_service.dart';
import 'package:http/http.dart' as http;

class LoanService {
  final url = "${dotenv.env["PUBLIC_API_BASE_V1"]}/loan/";
  Future<List<dynamic>> fetchLoanIndex() async {
    try {
      // get header di auth
      final headers = await AuthService().authTokenHeaders('josn');

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
}
