import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/models/chart_categories_periode_model.dart';
import 'package:tracking/services/auth_service.dart';

class ChartCategoryService {
  Future<ChartCategoriesPeriodeProps> getChartCategoriesPeriode(
      String periodeFilter) async {
    try {
      final headers = await AuthService().authTokenHeaders('json');
      final response = await http.get(
          Uri.parse(
            '${dotenv.env["PUBLIC_API_BASE_V1"]}/transaction/chart-categories-periode?periode=$periodeFilter',
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
