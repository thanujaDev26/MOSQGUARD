import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.apps),
            color: Colors.blue,
            onPressed: () {
              // Action for the grid icon
            },
          ),
          IconButton(
            icon: Icon(Icons.bug_report),
            color: Colors.blue,
            onPressed: () {
              //Navigator.push(
              //  context,
              //  MaterialPageRoute(builder: (context) => SecondPage()),
              //);
            },
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                // Action for the central "+" icon
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.blue,
            onPressed: () {
              // Action for the notification icon
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.blue,
            onPressed: () {
              // Action for the profile icon
            },
          ),
        ],
      ),
    );
  }
}
