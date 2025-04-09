import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Home_Body_Model.dart';

class ApiService {
  static Future<MessageCountModel> fetchMessageCounts() async {
    final response = await http.get(Uri.parse('http://172.20.10.2:3000/api/message-counts'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return MessageCountModel.fromJson(json);
    } else {
      throw Exception('Failed to load message counts');
    }
  }
}
