import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/onboarding_screen.dart';
import 'widget_tree.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(const Remedy());
}

class Remedy extends StatefulWidget {
  const Remedy({Key? key}) : super(key: key);

  @override
  State<Remedy> createState() => _RemedyState();
}

class _RemedyState extends State<Remedy> {
  MaterialColor remedyDarkBlue = MaterialColor(
      const Color.fromRGBO(3, 65, 114, 1).value, const <int, Color>{
    50: Color.fromRGBO(3, 65, 114, 0.1),
    100: Color.fromRGBO(3, 65, 114, 0.2),
    200: Color.fromRGBO(3, 65, 114, 0.3),
    300: Color.fromRGBO(3, 65, 114, 0.4),
    400: Color.fromRGBO(3, 65, 114, 0.5),
    500: Color.fromRGBO(3, 65, 114, 0.6),
    600: Color.fromRGBO(3, 65, 114, 0.7),
    700: Color.fromRGBO(3, 65, 114, 0.8),
    800: Color.fromRGBO(3, 65, 114, 0.9),
    900: Color.fromRGBO(3, 65, 114, 1),
  });

  MaterialColor remedyLightBlue = MaterialColor(
      const Color.fromRGBO(110, 206, 242, 1).value, const <int, Color>{
    50: Color.fromRGBO(110, 206, 242, 0.1),
    100: Color.fromRGBO(110, 206, 242, 0.2),
    200: Color.fromRGBO(110, 206, 242, 0.3),
    300: Color.fromRGBO(110, 206, 242, 0.4),
    400: Color.fromRGBO(110, 206, 242, 0.5),
    500: Color.fromRGBO(110, 206, 242, 0.6),
    600: Color.fromRGBO(110, 206, 242, 0.7),
    700: Color.fromRGBO(110, 206, 242, 0.8),
    800: Color.fromRGBO(110, 206, 242, 0.9),
    900: Color.fromRGBO(110, 206, 242, 1),
  });

  MaterialColor remedyLightGreen = MaterialColor(
      const Color.fromRGBO(82, 222, 160, 1).value, const <int, Color>{
    50: Color.fromRGBO(82, 222, 160, 0.1),
    100: Color.fromRGBO(82, 222, 160, 0.2),
    200: Color.fromRGBO(82, 222, 160, 0.3),
    300: Color.fromRGBO(82, 222, 160, 0.4),
    400: Color.fromRGBO(82, 222, 160, 0.5),
    500: Color.fromRGBO(82, 222, 160, 0.6),
    600: Color.fromRGBO(82, 222, 160, 0.7),
    700: Color.fromRGBO(82, 222, 160, 0.8),
    800: Color.fromRGBO(82, 222, 160, 0.9),
    900: Color.fromRGBO(82, 222, 160, 1),
  });

  MaterialColor remedySkyBlue = MaterialColor(
      const Color.fromRGBO(208, 242, 255, 1).value, const <int, Color>{
    50: Color.fromRGBO(208, 242, 255, 0.1),
    100: Color.fromRGBO(208, 242, 255, 0.2),
    200: Color.fromRGBO(208, 242, 255, 0.3),
    300: Color.fromRGBO(208, 242, 255, 0.4),
    400: Color.fromRGBO(208, 242, 255, 0.5),
    500: Color.fromRGBO(208, 242, 255, 0.6),
    600: Color.fromRGBO(208, 242, 255, 0.7),
    700: Color.fromRGBO(208, 242, 255, 0.8),
    800: Color.fromRGBO(208, 242, 255, 0.9),
    900: Color.fromRGBO(208, 242, 255, 1),
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 208, 242, 255),
        primarySwatch: remedyDarkBlue,
      ),
      initialRoute:
          initScreen == 0 || initScreen == null ? 'onBoarding' : 'widgetTree',
      routes: {
        'widgetTree': (context) => const WidgetTree(),
        'onBoarding': (context) => OnBoardingScreen(),
      },
    );
  }
}
