import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'medicine_list.dart';

class MedicineDescriptionDetails extends StatefulWidget {
  const MedicineDescriptionDetails({super.key});

  @override
  State<MedicineDescriptionDetails> createState() =>
      _MedicineDescriptionDetailsState();
}

class _MedicineDescriptionDetailsState
    extends State<MedicineDescriptionDetails> {
  Stream<List<Medicine>> medicineList() => FirebaseFirestore.instance
      .collection('medicineList')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Medicine.fromJson(doc.data())).toList());

  Widget getList(Medicine medicine) => ListTile(
        title: Text(medicine.name),
        subtitle: Text(medicine.type),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List"),
      ),
      body: StreamBuilder<List<Medicine>>(
        stream: medicineList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('wrong: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final meds = snapshot.data!;
            return ListView(
              children: meds.map(getList).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
