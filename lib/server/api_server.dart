import 'dart:convert';
import 'package:http/http.dart' as http;
class OpenAIService {
  static const String _endpoint =
      'https://us-central1-aichatbot-99dec.cloudfunctions.net/chat';

  Future<String> sendMessage({
    required String message,
    required String mode,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message': message,
        'mode': mode,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    final data = jsonDecode(response.body);
    return data['reply'];
  }
}
