import 'package:flutter/material.dart';
import 'package:mosqguard/pages/AboutUs/AboutUs.dart';
import 'package:mosqguard/pages/ContactUs/ContactUs.dart';
import 'package:mosqguard/pages/splash/splash.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),  // Light Mode Theme
      darkTheme: ThemeData.dark(), // Dark Mode Theme
      themeMode: themeNotifier.themeMode, // Uses selected theme
      home: const Splash(),
      routes: <String, WidgetBuilder>{
        '/aboutus': (context)=>Aboutus(),
        '/contactus': (context)=>Contactus(),
      },
    );
  }
}
