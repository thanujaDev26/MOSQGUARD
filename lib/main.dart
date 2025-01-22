import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false, // Remove default back button
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dengue Hotspot',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            // Menu button action
                          },
                        ),
                        SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            text: 'MOS',
                            style: TextStyle(
                              color: Colors.white,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.article, color: Colors.white),
                      onPressed: () {
                        // News button action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Text('Content goes here'),
        ),
      ),
    );
  }
}
