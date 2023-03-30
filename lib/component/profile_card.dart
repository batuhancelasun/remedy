import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

String? myEmail;
String? myName;
String? myBloodType;
_fetch() async {
  final firebaseUser = Auth().currentUser;
  if (firebaseUser != null) {
    await FirebaseFirestore.instance
        .collection('Person')
        .doc(firebaseUser.uid)
        .get()
        .then(
      (ds) {
        myEmail = ds.data()!['email'];
        myName = ds.data()!['name'];
        myBloodType = ds.data()!['kanGrubu'];
      },
    );
  }
}

bool edit = false;

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        });
  }
}

Widget _buildSingleContainer(
    {required Color color,
    required String startText,
    required String endText}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: Container(
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: edit == true ? color : Colors.white,
        borderRadius: edit == false
            ? BorderRadius.circular(30)
            : BorderRadius.circular(0),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            startText,
            style: TextStyle(fontSize: 17, color: Colors.black45),
          ),
          Text(
            endText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}









                    // Card(
                    //   //FIRSTNAME CARD
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30)),
                    //   child: Container(
                    //     height: 55,
                    //     padding: const EdgeInsets.symmetric(horizontal: 20),
                    //     decoration: BoxDecoration(
                    //         color: edit == false
                    //             ? const Color.fromRGBO(110, 206, 242, 1)
                    //             : const Color.fromRGBO(82, 222, 160, 1),
                    //         borderRadius: BorderRadius.circular(30)),
                    //     width: double.infinity,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         const Text(
                    //           "First Name: ",
                    //           style: TextStyle(
                    //               fontSize: 17, color: Colors.black45),
                    //         ),
                    //         userName(userProfile)
                    //       ],
                    //     ),
                    //   ),
                    // ),