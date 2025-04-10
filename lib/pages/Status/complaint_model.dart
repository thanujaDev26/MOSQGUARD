import 'package:intl/intl.dart';

class Complaint {
  final String location;
  final String datetime;
  final String status;
  final String imageUrl;

  Complaint({
    required this.location,
    required this.datetime,
    required this.status,
    required this.imageUrl,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    String complaintTime = json['complaintTime'] ?? '';
    DateTime dateTime = DateTime.parse(complaintTime);
    String formattedDatetime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return Complaint(
      location: json['location'] ?? '',
      datetime: formattedDatetime,
      status: json['status'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
