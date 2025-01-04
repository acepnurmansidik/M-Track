import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/models/wallet_model.dart';
import 'package:tracking/services/auth_service.dart';

class WalletService {
  Future<List<dynamic>> getListWallet() async {
    try {
      // get token from local storage
      final header = await AuthService().authTokenHeaders('json');

      // hit api to get wallet list
      final response = await http.get(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/wallet'),
        headers: header,
      );

      // decode response to map
      final data = json.decode(response.body);

      // mapping data to WalletModel
      List<dynamic> result =
          data["data"].map((item) => WalletModel.fromJson(item)).toList();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createWallet(body) async {
    try {
      // get jwt from local storage
      final header = await AuthService().authTokenHeaders('json');
      // hit api post wallet
      final response = await http.post(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/wallet/'),
        body: body,
        headers: header,
      );

      // decode response
      final data = json.decode(response.body);
      // check response
      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWallet(id) async {
    try {
      // get jwt from local storage
      final header = await AuthService().authTokenHeaders('json');
      // hit api post wallet
      final response = await http.delete(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/wallet/$id'),
        headers: header,
      );

      // decode response
      final data = json.decode(response.body);
      // check response
      if (data["code"] >= 400) {
        throw HttpException(data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
