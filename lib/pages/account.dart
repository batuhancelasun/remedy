import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import '../component/user_credentials.dart';
import '../widget_tree.dart';
import 'home_page.dart';

class AccountInfo extends StatefulWidget {
  AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final User? currentUser = Auth().currentUser;

  final FirebaseFirestore _firestoreAuth = FirebaseFirestore.instance;

  final TextEditingController name = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController idnumber = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController bloodtype = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      usercredentials.bloodType,
      style: const TextStyle(fontSize: 20, color: Colors.black),
    );
  }

  Future<void> signOut() async {
    await Auth().signOut();
    Get.to(const WidgetTree());
  }

  void validation() async {
    if (name.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("First Name field is empty!")));
    } else if (lastname.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Last Name field is empty!")));
    } else if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("E-mail field is empty!")));
    } else if (idnumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ID Number field is empty!")));
    } else if (gender.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gender field is empty!")));
    } else if (bloodtype.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Blood Type field is empty!")));
    } else {
      userDetailUpdate();
    }
  }

  bool centerCircle = false;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    FirebaseFirestore.instance
        .collection("Person")
        .doc(currentUser?.uid)
        .update({
      'name': name.text,
      'surName': lastname.text,
      'email': email.text,
      'idNumber': idnumber.text,
      'bloodType': bloodtype.text,
      'gender': gender.text,
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: edit == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
                // ignore: prefer_const_constructors
                icon: Icon(Icons.close_rounded),
              )
            : IconButton(
                onPressed: () => Get.to(const MyHomePage()),
                icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          edit == true
              ? IconButton(
                  onPressed: () {
                    validation();
                  },
                  icon: const Icon(Icons.check_rounded))
              : IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () {
                    signOut();
                  },
                )
        ],
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
                      width: 180,
                      height: 250,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: const Image(
                            image:
                                AssetImage("images/male_profile_picture.png"),
                          )),
                    ),

                    Card(
                      //FIRSTNAME CARD
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: edit == false
                                ? const Color.fromRGBO(110, 206, 242, 1)
                                : const Color.fromRGBO(82, 222, 160, 1),
                            borderRadius: BorderRadius.circular(30)),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "First Name: ",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black45),
                            ),
                            userName(userProfile)
                          ],
                        ),
                      ),
                    ),

                    Card(
                      //LASTNAME CARD
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: edit == false
                                ? const Color.fromRGBO(110, 206, 242, 1)
                                : const Color.fromRGBO(82, 222, 160, 1),
                            borderRadius: BorderRadius.circular(30)),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Last Name: ",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black45),
                            ),
                            userSurname(userProfile)
                          ],
                        ),
                      ),
                    ),

                    Card(
                      //EMAIL CARD
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: edit == false
                                ? const Color.fromRGBO(110, 206, 242, 1)
                                : const Color.fromRGBO(82, 222, 160, 1),
                            borderRadius: BorderRadius.circular(30)),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "E-Mail: ",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black45),
                            ),
                            userEmail(userProfile)
                          ],
                        ),
                      ),
                    ),

                    Card(
                      //IDNUMBER CARD
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: edit == false
                                ? const Color.fromRGBO(110, 206, 242, 1)
                                : const Color.fromRGBO(82, 222, 160, 1),
                            borderRadius: BorderRadius.circular(30)),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "ID Number: ",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black45),
                            ),
                            userIdNumber(userProfile)
                          ],
                        ),
                      ),
                    ),

                    Card(
                      //GENDER CARD
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: edit == false
                                ? const Color.fromRGBO(110, 206, 242, 1)
                                : const Color.fromRGBO(82, 222, 160, 1),
                            borderRadius: BorderRadius.circular(30)),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Gender: ",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black45),
                            ),
                            userGender(userProfile)
                          ],
                        ),
                      ),
                    ),

                    Card(
                      //BLOODTYPE CARD
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: edit == false
                                ? const Color.fromRGBO(110, 206, 242, 1)
                                : const Color.fromRGBO(82, 222, 160, 1),
                            borderRadius: BorderRadius.circular(30)),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Blood Type: ",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black45),
                            ),
                            userBloodType(userProfile)
                          ],
                        ),
                      ),
                    ),

                    // ignore: prefer_const_constructors
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          edit = true;
                        });
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(82, 222, 160, 1)),
                          side: MaterialStatePropertyAll(BorderSide.none),
                          shape: MaterialStatePropertyAll(StadiumBorder())),
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
