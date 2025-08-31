import 'package:tracking/models/user_model.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/services/auth_service.dart';

class UserService {
  Future<UserModelProps> getUserProfile() async {
    try {
      final headers = await AuthService().authTokenHeaders('json');
      final response = await http.get(
        Uri.parse(
          '${dotenv.env["PUBLIC_API_BASE_V1"]}/user/profile',
        ),
        headers: headers,
      );

      final result = UserModelProps.fromJson(json.decode(response.body));

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
