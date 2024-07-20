import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tracking/models/refparameter_model.dart';
import 'package:tracking/services/auth_service.dart';

class RefparameterService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<List<dynamic>> fetchListParameter({queryType, preserve}) async {
    try {
      final header = await AuthService().authTokenHeaders('json');

      final response = await http.get(
          Uri.parse(
              '$baseUrl/ref-parameter/?type=$queryType&preserve=$preserve'),
          headers: header);
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
