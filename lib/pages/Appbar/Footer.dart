import 'package:flutter/material.dart';
import '../Status/Status.dart';
import '../capture/capture.dart';
import '../notification/Notification.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import '../profile/mainProfilePage.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        BottomNavigationBar(
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      print("object");
                    },
                    child: Icon(Icons.grid_view)),
                label: ""),

            BottomNavigationBarItem(icon: Icon(Icons.bug_report), label: ""),

            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Status()));
                    },
                    child: Icon(Icons.bug_report)), label: ""
            ),

            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Capture()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Icon(
                    Icons.add_circle,
                    size: 70,
                    color: Color(0xff002353),
                  ),
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  // Navigate to mainprofile.dart when the person icon is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MainProfilePage()), // Navigate to mainprofile
                  );
                },
                child: Icon(Icons.person),
              ),
              label: "",
            ),
          ],
        ),
      ],
    );
  }
}
