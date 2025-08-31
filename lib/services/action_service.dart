import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tracking/services/auth_service.dart';

class ActionService {
  Future<void> delete(String path) async {
    try {
      final headers = await AuthService().authTokenHeaders('json');

      await http.delete(
        Uri.parse('${dotenv.env["PUBLIC_API_BASE_V1"]}$path'),
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }
}
