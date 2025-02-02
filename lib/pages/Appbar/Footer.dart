import 'package:flutter/material.dart';
import '../capture/capture.dart';
import '../profile/mainProfilePage.dart';

class CustomBottomBar extends StatelessWidget {
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
            BottomNavigationBarItem(icon: Icon(Icons.bug_report), label: ""),
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
