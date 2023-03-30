import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/a.dart';
import '../getDatas/get_google_maps_data.dart';

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.to(MyHomePage()),
          ),
        ),
        body: const GetGoogleMapsData());
  }
}
