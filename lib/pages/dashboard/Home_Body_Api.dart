import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Home_Body_Model.dart';

class ApiService {
  static Future<MessageCountModel> fetchMessageCounts() async {
    try {
      print('Attempting to fetch from API Dashboard...');

    final response = await http.get(Uri.parse('http://172.20.10.2:3000/api/message-counts'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return MessageCountModel.fromJson(json);
      } else {
        throw Exception('Server responded with status ${response.statusCode}');
      }
    } catch (e) {
      print('API call error: $e');
      rethrow;
    }
  }
}
