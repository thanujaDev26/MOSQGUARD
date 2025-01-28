import 'package:flutter/material.dart';
import 'package:mosqguard/pages/Appbar/Header.dart';
import 'package:mosqguard/pages/Appbar/Footer.dart';
import 'package:mosqguard/pages/dashboard/HomeBody.dart';
import 'package:mosqguard/pages/Appbar/Drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomHome(),
      drawer: CustomDrawer(), // The Sidebar is now connected here
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
