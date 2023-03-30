import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/a.dart';
import '../getDatas/get_medlist_data.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.to(const MyHomePage()),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(3, 65, 114, 1),
          title: const Text('Medicine Description List'),
        ),
        body: const GetMedListData());
  }
}
