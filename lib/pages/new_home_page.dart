import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import '../component/nav_bar.dart';
import '../getDatas/datas/user_credentials.dart';
import 'medicine_page.dart';

class NewHomePage extends StatelessWidget {
  NewHomePage({super.key});

  final User? currentUser = Auth().currentUser;

  final FirebaseFirestore _firestoreAuth = FirebaseFirestore.instance;
  final TextEditingController _inputNameController = TextEditingController();

  Future<UserCredentials?> okuUser() async {
    final docUser = _firestoreAuth.collection('Person').doc(currentUser?.uid);
    final snaphot = await docUser.get();
    if (snaphot.exists) {
      return UserCredentials.fromJson(snaphot.data()!);
    }
  }

  Widget buildUser(UserCredentials usercredentials) {
    return Text(
      usercredentials.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Remedy"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          height: MediaQuery.of(context).size.height,
          color: Colors.blueGrey.shade300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 15,
                            blurRadius: 50,
                            offset: const Offset(0, 1),
                          )
                        ]),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              "images/medicine_icon.png",
                              height: 80.0,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Text(
                            "Medicine Descriptions",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Text(
                            "Detailed Prospectus",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: () => Get.to(const MedicinePage()),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              "images/medicine_icon.png",
                              height: 80.0,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Text(
                            "Medicine Descriptions",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Text(
                            "Detailed Prospectus",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 15,
                            blurRadius: 50,
                            offset: const Offset(0, 1),
                          )
                        ]),
                  ),
                  onPressed: () => Get.to(const MedicinePage()),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            "images/medicine_icon.png",
                            height: 80.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          "Medicine Descriptions",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          "Detailed Prospectus",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 15,
                            blurRadius: 50,
                            offset: const Offset(0, 1),
                          )
                        ]),
                  ),
                  onPressed: () => Get.to(const MedicinePage()),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              "images/medicine_icon.png",
                              height: 80.0,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Text(
                            "Medicine Descriptions",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Text(
                            "Detailed Prospectus",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 15,
                            blurRadius: 50,
                            offset: const Offset(0, 1),
                          )
                        ]),
                  ),
                  onPressed: () => Get.to(const MedicinePage()),
                ),
              ),
            ],
          ),
        ));
  }
}
