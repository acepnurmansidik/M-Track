import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/models/chart_categories_periode_model.dart';

class ChartCategoryService {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization':
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFjZXBudXJtYW5AZ21haWwuY29tIiwibmFtZSI6ImFjZXAgbnVybWFuIHNpZGlrIiwiaWF0IjoxNzU2MDMxMzk0LCJleHAiOjE3NTY2MzYxOTQsImp0aSI6Ijg0MmIwNDM1ODdiNzQ3ZTU4N2Q0MWZjNDVlZDE4ZjgwIn0.4cHBQmmq6Mdr3SGMQ_Q72cd48VbpxYW0mA6U99Fq4uPpW8sBbVKiHExtUQgEbiTKVWYkCvL3W1vL-Kk8zRuYwA",
  };

  Future<ChartCategoriesPeriodeProps> getChartCategoriesPeriode() async {
    try {
      final response = await http.get(
          Uri.parse(
            '${dotenv.env["PUBLIC_API_BASE_V1"]}/transaction/chart-categories-periode',
          ),
          headers: headers);

      final result =
          ChartCategoriesPeriodeProps.fromJson(json.decode(response.body));

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
