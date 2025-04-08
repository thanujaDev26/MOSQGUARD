import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportService {
  static const String baseUrl = 'http://192.168.8.129:3000/api'; // Use your actual backend URL

  Future<Map<String, dynamic>> getMonthlyReport() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/monthly_report'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load report: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}