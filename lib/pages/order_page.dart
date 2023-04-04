import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  //Order page will be added with the next version of the app.
  //We will add stock and easy pay functions to let users order their medicines easily.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(const MyHomePage()),
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("Order"),
      ),
      body: Image.asset(
        "images/coming_soon.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
