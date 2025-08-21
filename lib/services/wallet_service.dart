import 'dart:convert';

import 'package:tracking/models/wallet_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WalletService {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization':
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFjZXBudXJtYW5AZ21haWwuY29tIiwibmFtZSI6ImFjZXAgbnVybWFuIHNpZGlrIiwiaWF0IjoxNzU1NDcxNzIxLCJleHAiOjE3NTYwNzY1MjEsImp0aSI6Ijg0MmIwNDM1ODdiNzQ3ZTU4N2Q0MWZjNDVlZDE4ZjgwIn0.NHxitpmANC1LgYI4UOdJ9NAo70xkKublkixjh0pzfvYHxfpOf-iXI_TEj5qE0pVRLVnYnQqyLnPw0IAAsYtuwg",
  };

  Future<WalletModelProps> getAllWalletUser() async {
    try {
      final response = await http.get(
          Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}/wallet'),
          headers: headers);

      final result = WalletModelProps.fromJson(json.decode(response.body));

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
