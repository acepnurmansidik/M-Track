import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/models/categories_model.dart';

class CategoryService {
  Future<CategoriesModelProps> getCategories() async {
    try {
      final response = await http.get(Uri.parse(
          '${dotenv.env["PUBLIC_API_BASE_V1"]}/transaction/category'));
      final result = CategoriesModelProps.fromJson(json.decode(response.body));

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
