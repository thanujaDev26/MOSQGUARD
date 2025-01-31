import 'package:flutter/material.dart';
import '../Status/Status.dart';
import '../capture/capture.dart';
import '../notification/Notification.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BottomNavigationBar(
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
            BottomNavigationBarItem(icon: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Icon(Icons.notifications),
              ),
            ),
                label: ""
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
          ],
        ),
      ],
    );
  }
}
