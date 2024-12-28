import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/models/refparameter_model.dart';
import 'package:tracking/services/auth_service.dart';

class RefparameterService {
  Future<List<dynamic>> fetchListParameter({url}) async {
    try {
      final header = await AuthService().authTokenHeaders('json');

      final response = await http.get(
          Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/ref-parameter/$url'),
          headers: header);
      final data = json.decode(response.body);

      List<dynamic> result = await data["data"]
          .map((item) => ReffParameterModel.fromJson(item))
          .toList();

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createNewReffparam(body) async {
    try {
      // ambil token di service auth
      final header = await AuthService().authTokenHeaders('json');

      // hit api postya
      final response = await http.post(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/ref-parameter/'),
        body: body,
        headers: header,
      );
      final data = json.decode(response.body);

      // cek jika ada error
      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
