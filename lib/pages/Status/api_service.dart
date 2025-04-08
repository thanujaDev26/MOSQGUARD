// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'complaint_model.dart';

class ApiService {
  static Future<List<Complaint>> fetchComplaints() async {
    final response = await http.get(Uri.parse('http://192.168.181.241:3000/api/complain'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic>? complaintsData = jsonData['data']?['complaints'];

      if (complaintsData == null || complaintsData.isEmpty) {
        return [];
      }
      return complaintsData.map((item) => Complaint.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load complaints');
    }
  }
}



