import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mosqguard/pages/AboutUs/AboutUs.dart';
import 'package:mosqguard/pages/ContactUs/ContactUs.dart';
import 'package:mosqguard/pages/Privacy_Policy/Privacy_Policy.dart';
import 'package:mosqguard/pages/splash/splash.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/pages/News/News.dart';

import 'pages/dashboard/Monthly_Report.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.themeMode,
      home: const Splash(),
      routes: <String, WidgetBuilder>{
        '/aboutus': (context)=>Aboutus(),
        '/contactus': (context)=>Contactus(),
        '/news': (context)=>News(),
        '/monthly_report': (context)=>MonthlyReportPage(),
        '/privacyandpolicy': (context)=>PrivacyPolicyPage(),
      },
    );
  }
}
