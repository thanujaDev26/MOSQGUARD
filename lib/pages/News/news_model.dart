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
    return News(
      id: json['EventId'],
      title: json['title'],
      message: json['message'],
      date: json['date'],
      venue: json['venue'],
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
    );
  }
}
