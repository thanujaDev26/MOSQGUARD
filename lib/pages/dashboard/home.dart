import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("Home Page"),
        ),
      body: Container(
        child: Column(
          children: [
            Text("Hello")
          ],
        ),
      ),
    );
  }
}
