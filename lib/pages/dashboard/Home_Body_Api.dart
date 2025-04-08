import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Home_Body_Model.dart';

class ApiService {
  static Future<MessageCountModel> fetchMessageCounts() async {
    final url = Uri.parse('http://192.168.8.129:3000/api/message-counts'); // Replace with your actual API endpoint

    final response = await http.get(url);


    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return MessageCountModel.fromJson(json);
    } else {
      throw Exception('Failed to load message counts');
    }
  }
}
