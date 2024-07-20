import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/models/auth_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:3022/api/v1";

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> authRegister(body) async {
    try {
      String? token = await messaging.getToken();
      body["token"] = token;
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

  Future<Map<String, String>> authTokenHeaders(String contentType) async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    String? tokeAvailable = await storage.read(key: 'token');
    String typeheader;

    switch (contentType) {
      case 'json':
        typeheader = 'application/x-www-form-urlencoded; charset=utf-8';
        break;
      default:
        typeheader = 'application/x-www-form-urlencoded; charset=utf-8';
    }

    return <String, String>{
      'Content-Type': typeheader,
      'authorization': tokeAvailable!
    };
  }
}
