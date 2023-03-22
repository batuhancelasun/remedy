import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remedy/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Remedy());
}

//sümooooss
class Remedy extends StatelessWidget {
  const Remedy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 208, 242, 255),
        primarySwatch: Colors.blue,
      ),
      home: const WidgetTree(),
    );
  }
}
