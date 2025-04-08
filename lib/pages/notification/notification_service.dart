class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  List<Map<String, dynamic>> notifications = [];

  void addNotification(Map<String, dynamic> notification) {
    notifications.insert(0, notification);
  }

  List<Map<String, dynamic>> getNotifications() => notifications;
}
