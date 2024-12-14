import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/models/refparameter_model.dart';
import 'package:tracking/services/auth_service.dart';

class RefparameterService {
  Future<List<dynamic>> fetchListParameter({queryType, preserve}) async {
    try {
      final header = await AuthService().authTokenHeaders('json');

      final response = await http.get(
          Uri.parse(
              '${dotenv.env["PUBLIC_API_BASE_V1"]}/ref-parameter/?type=$queryType&preserve=$preserve'),
          headers: header);
      final data = json.decode(response.body);

      List<dynamic> result = await data["data"]
          .map((item) => ReffGroupParameterModel.fromJson(item))
          .toList();

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
