import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetMedListData extends StatefulWidget {
  const GetMedListData({super.key});

  @override
  State<GetMedListData> createState() => _GetMedListDataState();
}

class _GetMedListDataState extends State<GetMedListData> {
  @override
  Widget build(BuildContext context) {
    CollectionReference meds =
        FirebaseFirestore.instance.collection('medicineList');

    return StreamBuilder(
      stream: meds.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset("images/medicine.png"),
                  title: Text(documentSnapshot['name']),
                  subtitle: Text(documentSnapshot['type']),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 700,
                              width: 550,
                              child: SingleChildScrollView(
                                child: Text(
                                  documentSnapshot['description'],
                                ),
                              ),
                            ),
                            title: Text(documentSnapshot['name']),
                          );
                        });
                  },
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
