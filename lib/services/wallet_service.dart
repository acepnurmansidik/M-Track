import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/models/wallet_model.dart';
import 'package:tracking/services/auth_service.dart';
import 'package:http/http.dart' as http;

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
}
