import 'package:flutter/material.dart';
import 'package:mosqguard/pages/notification/Notification.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70); // Proper preferredSize getter
}

class _CustomAppBarState extends State<CustomAppBar> {
  int newNotificationsCount = 3;  // Initial notification count

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return AppBar(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      titleTextStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: isDarkMode ? Colors.white : Colors.black),
                    onPressed: () {
                      Scaffold.maybeOf(context)?.openDrawer();
                    },
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      text: 'MOS',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: 'Q',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: 'GUARD',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications, color: isDarkMode ? Colors.white : Colors.black),
                    onPressed: () {
                      // Push NotificationPage and update the count
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationPage(
                            onNotificationUpdate: (newCount) {
                              setState(() {
                                newNotificationsCount = newCount;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  if (newNotificationsCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '$newNotificationsCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
