import 'package:flutter/material.dart';
import 'package:mosqguard/pages/notification/notification_service.dart';

class NotificationPage extends StatefulWidget {
  final Function(int) onNotificationUpdate;

  const NotificationPage({super.key, required this.onNotificationUpdate});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    notifications = NotificationService().getNotifications();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onNotificationUpdate(notifications.length);
    });
  }

  void _removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
    widget.onNotificationUpdate(notifications.length);
  }

  @override
  void dispose() {
    // When closing the screen, send back the updated count
    Navigator.pop(context, notifications.length);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: notifications.isEmpty
          ? const Center(
        child: Text(
          "No notifications",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              color: Colors.red.withOpacity(0.8),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => _removeNotification(index),
            child: _buildNotificationCard(
              icon: notif['icon'],
              title: notif['title'],
              description: notif['description'],
              timestamp: notif['timestamp'],
              iconColor: notif['iconColor'],
              index: index,
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required String description,
    required String timestamp,
    required Color iconColor,
    required int index,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Text(
              timestamp,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.grey),
          onPressed: () => _removeNotification(index),
        ),
      ),
    );
  }
}
