import 'package:flutter/material.dart';
import 'package:mosqguard/pages/Appbar/Header.dart';
import 'package:mosqguard/pages/Appbar/Footer.dart';
import 'package:mosqguard/pages/Status/Status_body.dart';
import 'package:mosqguard/pages/Appbar/Drawer.dart';

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: StatusBody(),
      drawer: CustomDrawer(), // The Sidebar is now connected here
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
