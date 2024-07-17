import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tracking/models/auth_model.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  Future<void> authRegister(body) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/auth/signup'), body: body);
      final data = json.decode(response.body);

      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthModel> authLogin(body) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/auth/signin'), body: body);

      final data = json.decode(response.body);

      AuthModel auth = AuthModel.fromJson(data["data"]);

      return auth;
    } catch (e) {
      rethrow;
    }
  }
}
