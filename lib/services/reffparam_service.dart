import 'dart:convert';

import 'package:tracking/models/refparameter_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/services/auth_service.dart';

class ReffparamService {
  Future<ReffParamModelProps> getReffParam() async {
    try {
      final headers = await AuthService().authTokenHeaders('json');
      final response = await http.get(
          Uri.parse(
            '${dotenv.env["PUBLIC_API_BASE_V1"]}/ref-parameter/?type=cashflow_type',
          ),
          headers: headers);

      final result = ReffParamModelProps.fromJson(json.decode(response.body));

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
