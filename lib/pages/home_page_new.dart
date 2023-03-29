import 'package:flutter/material.dart';

import '../component/nav_bar.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Remedy"),
      ),
      body: Center(),
    );
  }
}
