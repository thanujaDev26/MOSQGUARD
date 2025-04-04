import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mosqguard/pages/AboutUs/AboutUs.dart';
import 'package:mosqguard/pages/ContactUs/ContactUs.dart';
import 'package:mosqguard/pages/onBoardingScreens/onboarding.dart';
import 'package:mosqguard/pages/splash/splash.dart';
import 'package:mosqguard/utils/language_notifier.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/pages/News/News.dart';

import 'pages/dashboard/Monthly_Report.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';




// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeNotifier(),
//       child: const MyApp(),
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => LanguageNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    return MaterialApp(
        locale: languageNotifier.locale,
        supportedLocales: const [
          Locale('en'),
          Locale('si'),
          Locale('ta'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
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
        // '/onboarding': (context)=>OnboardingPage(),
      }
    );
  }
}
