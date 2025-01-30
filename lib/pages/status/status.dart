import 'package:flutter/material.dart';
import 'package:mosqguard/pages/Appbar/Header.dart';
import 'package:mosqguard/pages/Appbar/Footer.dart';
import 'package:mosqguard/pages/Status/Status_body.dart';
import 'package:mosqguard/pages/Appbar/Drawer.dart';
import 'package:mosqguard/pages/sidebar/sidebar.dart';
import 'package:mosqguard/pages/sidebar/sidebar.dart';

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // leading: Builder(
          //   builder: (context) => IconButton(
          //     icon: Icon(Icons.menu, color: Colors.black, size: 30),
          //     onPressed: () {
          //       Scaffold.of(context).openDrawer();
          //     },
          //   ),
          // ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/mosqguard/Logo-3.png',
                width: 150,
              ),
            ],
          ),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.list, color: Colors.black, size: 30),
          //     onPressed: () {},
          //   ),
          //   SizedBox(width: 10),
          // ],
        ),
      body: StatusBody(),
    );
  }
}
