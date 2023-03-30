import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import '../component/nav_bar.dart';
import '../component/order.dart';
import '../component/user_credentials.dart';
import 'account.dart';
import 'google_maps.dart';
import 'medicine_description.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

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

class _MyHomePageState extends State<MyHomePage> {
  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 1), // changes position of shadow
        ),
      ],
    );
  }

  Widget userName(UserCredentials usercredentials) {
    return Text(
      usercredentials.name,
      style:
          const TextStyle(fontSize: 20, color: Color.fromRGBO(3, 65, 114, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Remedy",
        ),
      ),
      body: FutureBuilder<UserCredentials?>(
          future: okuUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final okuUser = snapshot.data!;
              return Container(
                padding: const EdgeInsets.only(left: 0),
                height: 470,
                width: 450,
                //color: Colors.grey.shade300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "images/banner.png",
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Hello, ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(3, 65, 114, 1)),
                        ),
                        userName(okuUser),
                        const Text(
                          "! ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(3, 65, 114, 1)),
                        ),
                        const Text(
                          "Welcome back to Remedy!",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(3, 65, 114, 1)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () =>
                                Get.to(const MedicineDescription()),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: const EdgeInsets.all(0),
                              decoration: getBoxDecoration(),
                              width: 180,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'images/medicine_icon.png',
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
                                      "Read Detailed Prospectus",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0,
                                          color:
                                              Color.fromRGBO(82, 222, 160, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.to(const MapsPage()),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: const EdgeInsets.all(0),
                              decoration: getBoxDecoration(),
                              width: 180,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'images/location_icon.png',
                                        height: 80.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      "Pharmacy Locations",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      "See Nearby Pharmacies",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0,
                                          color:
                                              Color.fromRGBO(82, 222, 160, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Get.to(const OrderPage()),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: const EdgeInsets.all(0),
                              decoration: getBoxDecoration(),
                              width: 180,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'images/order_icon.png',
                                        height: 80.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      "Order Now!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      "Get Your Medicines",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0,
                                          color:
                                              Color.fromRGBO(82, 222, 160, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.to(AccountInfo()),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: const EdgeInsets.all(0),
                              decoration: getBoxDecoration(),
                              width: 180,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'images/account_icon.png',
                                        height: 80.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      "My Account",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      "Check Your Profile Informations",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0,
                                          color:
                                              Color.fromRGBO(82, 222, 160, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
