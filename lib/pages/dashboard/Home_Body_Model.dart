class MessageCountModel {
  final int totalCount;
  final int past24HourCount;

  MessageCountModel({
    required this.totalCount,
    required this.past24HourCount,
  });

  factory MessageCountModel.fromJson(Map<String, dynamic> json) {
    return MessageCountModel(
      totalCount: json['total_count'],
      past24HourCount: json['past_24_hour_count'],
    );
  }
}
