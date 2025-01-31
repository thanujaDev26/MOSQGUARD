import 'package:flutter/material.dart';
import '../sidebar/sidebar.dart';
import '../Appbar/Footer.dart';
import '../Appbar/Header.dart';
import 'HomeBody.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomHome(),
      drawer: Sidebar(),
      bottomNavigationBar: CustomBottomBar(),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],

    );
  }
}
