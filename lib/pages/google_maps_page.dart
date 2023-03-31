import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getDatas/get_google_maps_data.dart';
import 'home_page.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pharmacy Locations"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.to(const MyHomePage()),
          ),
        ),
        body: const GetGoogleMapsData());
  }
}
