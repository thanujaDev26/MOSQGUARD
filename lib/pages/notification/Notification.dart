import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final Function(int) onNotificationUpdate;

  const NotificationPage({super.key, required this.onNotificationUpdate});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int newNotificationsCount = 3;

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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Add your notification cards here
          _buildNotificationCard(
            icon: Icons.warning_amber_rounded,
            title: "New Dengue Hotspot Alert",
            description: "A new dengue hotspot has been detected near your area.",
            timestamp: "5 min ago",
            iconColor: Colors.red,
          ),
          _buildNotificationCard(
            icon: Icons.water_drop,
            title: "Heavy Rain Expected",
            description: "Stay alert! Rainfall can increase mosquito breeding.",
            timestamp: "2 hours ago",
            iconColor: Colors.blue,
          ),
          _buildNotificationCard(
            icon: Icons.check_circle,
            title: "Issue Resolved",
            description: "A previously reported hotspot has been addressed.",
            timestamp: "1 day ago",
            iconColor: Colors.green,
          ),
          _buildNotificationCard(
            icon: Icons.check_circle,
            title: "Issue Resolved",
            description: "A previously reported hotspot has been addressed.",
            timestamp: "1 day ago",
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required String description,
    required String timestamp,
    required Color iconColor,
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
          onPressed: () {
            setState(() {
              if (newNotificationsCount > 0) newNotificationsCount--;
              widget.onNotificationUpdate(newNotificationsCount); // Pass the new count to parent
            });
          },
        ),
      ),
    );
  }
}
