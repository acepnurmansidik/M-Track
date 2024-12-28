import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/models/dashboard_model.dart';
import 'package:tracking/services/auth_service.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  Future<ActivityCategoryModel> getActivityCategory() async {
    try {
      // get token
      final headers = await AuthService().authTokenHeaders('json');

      // hit API
      final response = await http.get(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/trx/category-activity'),
        headers: headers,
      );

      // decode response API and mapping into model
      ActivityCategoryModel data = ActivityCategoryModel.fromJson(
          await json.decode(response.body)["data"]);

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
