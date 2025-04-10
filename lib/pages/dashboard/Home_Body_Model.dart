class MessageCountModel {
  final int total_count;
  final int past_24_hour_count;

  MessageCountModel({
    required this.total_count,
    required this.past_24_hour_count,
  });

  factory MessageCountModel.fromJson(Map<String, dynamic> json) {
    try {
      // Add validation and logging
      print('Raw JSON received: $json');

      // Verify JSON structure
      if (json['total_count'] == null || json['past_24_hour_count'] == null) {
        throw FormatException('Missing required fields in JSON response');
      }

      return MessageCountModel(
        total_count: json['total_count'] as int,
        past_24_hour_count: json['past_24_hour_count'] as int,
      );
    } catch (e) {
      print('JSON parsing error: $e');
      print('Problematic JSON: $json');
      rethrow;
    }
  }

  // Add conversion back to JSON for debugging
  Map<String, dynamic> toJson() => {
    'total_count': total_count,
    'past_24_hour_count': past_24_hour_count,
  };

  // Add toString() for easy debugging
  @override
  String toString() {
    return 'MessageCountModel{total_count: $total_count, past_24_hour_count: $past_24_hour_count}';
  }
}