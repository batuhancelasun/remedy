import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remedy/pages/home_page.dart';
import 'package:remedy/pages/medicine_description.dart';
import 'package:remedy/pages/onboarding_screen.dart';
import 'package:remedy/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Remedy());
}

//sümoooosssafasfasf
class Remedy extends StatelessWidget {
  const Remedy({Key? key}) : super(key: key);
//tfsasdasd
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 208, 242, 255),
        primarySwatch: Colors.blue,
      ),
      //home: const MedicineDescription(), //This home widget is used for new screens testing. Please do not delete it just comment it when you don't need it.
      home:
          OnBoardingScreen(), // This home widget is the actual home widget. Uncomment when you done with testing.
    );
  }
}
