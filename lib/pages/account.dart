import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../component/user_credentials.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({super.key});

  final User? currentUser = Auth().currentUser;

  final FirebaseFirestore _firestoreAuth = FirebaseFirestore.instance;
  final TextEditingController _inputNameController = TextEditingController();

  Future<UserCredentials?> userProfile() async {
    final docUser = _firestoreAuth.collection('Person').doc(currentUser?.uid);
    final snaphot = await docUser.get();

    if (snaphot.exists) {
      return UserCredentials.fromJson(snaphot.data()!);
    }
  }

  Widget userName(UserCredentials usercredentials) {
    return Text(
      usercredentials.name,
      style: const TextStyle(fontSize: 20, color: Colors.black),
    );
  }

  Widget userEmail(UserCredentials usercredentials) {
    return Text(
      usercredentials.email,
      style: const TextStyle(fontSize: 20, color: Colors.black),
    );
  }

  Widget userGender(UserCredentials usercredentials) {
    return Text(
      usercredentials.gender,
      style: const TextStyle(fontSize: 20, color: Colors.black),
    );
  }

  Widget userIdNumber(UserCredentials usercredentials) {
    return Text(
      usercredentials.idNumber,
      style: const TextStyle(fontSize: 20, color: Colors.black),
    );
  }

  Widget userSurname(UserCredentials usercredentials) {
    return Text(
      usercredentials.surname,
      style: const TextStyle(fontSize: 20, color: Colors.black),
    );
  }

  Widget userBloodType(UserCredentials usercredentials) {
    return Text(
      usercredentials.kanGrubu,
      style: const TextStyle(fontSize: 20, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account Information"),
      ),
      body: FutureBuilder<UserCredentials?>(
          future: userProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("wrong! ${snapshot.error}");
            } else if (snapshot.hasData) {
              final userProfile = snapshot.data!;
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(
                            image:
                                AssetImage("images/male_profile_picture.png"),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userName(userProfile),
                        const Text(" "),
                        userSurname(userProfile),
                      ],
                    ),
                    userEmail(userProfile),
                    const SizedBox(height: 20),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: const ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(82, 222, 160, 1)),
                            side: MaterialStatePropertyAll(BorderSide.none),
                            shape: MaterialStatePropertyAll(StadiumBorder())),
                        // ignore: sort_child_properties_last
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
