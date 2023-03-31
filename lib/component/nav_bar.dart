import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import '../pages/account.dart';
import '../pages/google_maps_page.dart';
import '../pages/home_page.dart';
import '../pages/medicine_page.dart';
import '../widget_tree.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    Get.to(const WidgetTree());
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();

  String? myEmail;
  String? myName;
  String? myLastName;

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
          myLastName = ds.data()!['surName'];
        },
      );
    }
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    "$myName" " " "$myLastName",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  accountEmail: Text("$myEmail"),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/navbar_background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromRGBO(3, 65, 114, 1),
            ),
            title: const Text("Home Page"),
            onTap: () => Get.to(const MyHomePage()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Color.fromRGBO(82, 222, 160, 1),
            ),
            title: const Text("Descriptions of Medicines"),
            onTap: () => Get.to(const MedicinePage()),
          ),
          ListTile(
            leading: const Icon(
              Icons.local_pharmacy_sharp,
              color: Color.fromRGBO(110, 206, 242, 1),
            ),
            title: const Text("Pharmacy List"),
            onTap: () => Get.to(const GoogleMapsPage()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              color: Color.fromRGBO(3, 65, 114, 1),
            ),
            title: const Text("Account"),
            onTap: () => Get.to(const AccountInfo()),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Color.fromRGBO(180, 11, 11, 1),
            ),
            title: const Text("Sign Out"),
            onTap: signOut,
          ),
        ],
      ),
    );
  }
}
