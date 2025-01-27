import 'package:flutter/material.dart';
import 'package:mosqguard/pages/Appbar/Header.dart';
import 'package:mosqguard/pages/Appbar/Footer.dart';
import 'package:mosqguard/pages/dashboard/HomeBody.dart';
import 'package:mosqguard/pages/Appbar/Drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Use the custom AppBar here
      drawer: const CustomDrawer(),
      body: Center(
        child: CustomHome(),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
