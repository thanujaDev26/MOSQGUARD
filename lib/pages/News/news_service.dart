import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart';

class NewsService {
  Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse('http://172.20.10.2:3000/api/news'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> newsList = data['data'];
      return newsList.map((e) => News.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
