import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tracking/models/refparameter_model.dart';

class RefparameterService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<List<dynamic>> fetchListParameter() async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/ref-parameter/?type=category&preserve=false'));
      final data = json.decode(response.body);

      List<dynamic> result = await data["data"]
          .map((item) => RefparameterModel.fromJson(item))
          .toList();

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
