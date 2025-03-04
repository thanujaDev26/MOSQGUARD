import 'package:flutter/material.dart';
import 'package:mosqguard/pages/Appbar/Header.dart';
import 'package:mosqguard/pages/Appbar/Footer.dart';
import 'package:mosqguard/pages/Status/Status_body.dart';
import 'package:mosqguard/pages/sidebar/sidebar.dart';
import 'package:mosqguard/pages/sidebar/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
          'Status',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      body: StatusBody(),
    );
  }
}
