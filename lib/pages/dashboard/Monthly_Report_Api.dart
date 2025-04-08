import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://localhost:3000/api';

  Future<Map<String, dynamic>> getMonthlyReport(String district) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/monthly_report?district=$district'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load report: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }

  Future<List<String>> getDistricts() async {
    // Implement this if you have an endpoint for districts
    await Future.delayed(Duration(milliseconds: 500)); // Simulated delay
    return ['District 1', 'District 2', 'District 3', 'District 4'];
  }
}