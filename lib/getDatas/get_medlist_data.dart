import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetMedListData extends StatelessWidget {
  const GetMedListData({super.key});

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
                  title: Text(documentSnapshot['name']),
                  subtitle: Text(documentSnapshot['type']),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 500,
                              width: 500,
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
