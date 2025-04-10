class News {
  final int id;
  final String title;
  final String message;
  final String date;
  final String venue;
  final List<String> imageUrls;

  News({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.venue,
    required this.imageUrls,
  });

  factory News.fromJson(Map<String, dynamic> json) {
  List<String> parsedImageUrls = [];

  if (json['imageUrls'] != null && json['imageUrls'] is String) {
    try {
      final decoded = jsonDecode(json['imageUrls']);
      parsedImageUrls = List<String>.from(decoded);
    } catch (e) {
     
    }
  }

  return News(
    id: json['EventId'],
    title: json['title'],
    message: json['message'],
    date: json['date'],
    venue: json['venue'],
    imageUrls: parsedImageUrls,
  );
}
}
