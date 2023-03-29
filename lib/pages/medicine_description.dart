import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/description_list.dart';
import '../component/medicine_description_details.dart';
import 'home_page.dart';

class MedicineDescription extends StatelessWidget {
  const MedicineDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.to(HomePage()),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(3, 65, 114, 1),
          title: const Text('Medicine Description List'),
        ),
        body: ListView.builder(
            itemCount: medicineList.length,
            itemBuilder: (context, index) {
              Medicine medicine = medicineList[index];
              return Card(
                child: ListTile(
                  title: Text(medicine.title),
                  //subtitle: Text(medicine.description),
                  leading: Image.asset(
                    "images/medicine.png",
                    height: 50,
                    width: 50,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    Get.to(MedicineDescriptionDetails(
                      medicine: medicine,
                    ));
                  },
                ),
              );
            }));
  }
}
