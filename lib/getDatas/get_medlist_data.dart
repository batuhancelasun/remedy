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
    //  for better readability i assign a variable to my collection
    CollectionReference meds =
        FirebaseFirestore.instance.collection('medicineList');

    //  Here we using StreamBuilder
    return StreamBuilder(
      //  stream is our collection's snahpshots.
      stream: meds.snapshots(),
      builder: (context, streamSnapshot) {
        //  if we get data successfully magic happens.
        if (streamSnapshot.hasData) {
          // we return a listview.builder, item count = our data's lenght.
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // here i assign our data and index to a variable
              //so if i need to access a spesific data for example 'name' i just need to type 'name'.
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.asset("images/medicine.png"),
                  //  i explained above.
                  title: Text(documentSnapshot['name']),
                  subtitle: Text(documentSnapshot['type']),
                  onTap: () {
                    //  when we tap a medicine, it will give us alert dialog that has leaflets in it.
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
                      },
                    );
                  },
                ),
              );
            },
          );
        }
        // if nothing happens and we just need to wait than we show a CircularProgressIndicator
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
