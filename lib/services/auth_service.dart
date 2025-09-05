// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/models/auth_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> authRegister(body) async {
    try {
      String? token = await messaging.getToken();
      body["token"] = token;
      final response = await http.post(
          Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/auth/signup'),
          body: body);
      final data = json.decode(response.body);

      if (!data["success"]) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthModelProps> authLogin(body) async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    try {
      final response = await http.post(
          Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/auth/signin'),
          body: body);

      final auth = AuthModelProps.fromJson(json.decode(response.body));
      storage.write(key: 'token', value: auth.data.token);

      return auth;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> authLogOut(BuildContext context) async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    try {
      await storage.delete(key: 'token');
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/sign-in',
        (route) => false,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> authLoginChecked(BuildContext context) async {
    try {
      final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
      String? tokeAvailable = await storage.read(key: 'token');

      if (tokeAvailable!.isEmpty || tokeAvailable == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      }
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
      'authorization': tokeAvailable!,
      'x-tracker-api-key': dotenv.env["PUBLIC_API_KEY"]!
    };
  }
}
