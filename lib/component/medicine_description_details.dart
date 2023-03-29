import 'package:flutter/material.dart';

import 'description_list.dart';

class MedicineDescriptionDetails extends StatelessWidget {
  const MedicineDescriptionDetails({super.key, required this.medicine});

  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(medicine.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20)),
        ]),
      ),
    );
  }
}
