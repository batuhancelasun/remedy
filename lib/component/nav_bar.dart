import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remedy/pages/account.dart';
import 'package:remedy/pages/google_maps.dart';
import 'package:remedy/pages/home_page.dart';
import 'package:remedy/pages/home_page_new.dart';
import 'package:remedy/pages/medicine_description.dart';

import '../auth.dart';
import '../widget_tree.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final User? user = Auth().currentUser;

  Widget get _userUid {
    return Text(user?.email ?? 'User email');
  }

  Future<void> signOut() async {
    await Auth().signOut();
    Get.to(const WidgetTree());
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
          UserAccountsDrawerHeader(
            accountName: Text(
              "Tahir Furkan Sarıdiken",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            accountEmail: Text(user?.email ?? 'User email'),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/navbar_background.png"),
              fit: BoxFit.cover,
            )),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromRGBO(3, 65, 114, 1),
            ),
            title: const Text("Home Page"),
            onTap: () => Get.to(const NewHomePage()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Color.fromRGBO(82, 222, 160, 1),
            ),
            title: const Text("Descriptions of Medicines"),
            onTap: () => Get.to(const MedicineDescription()),
          ),
          ListTile(
            leading: const Icon(
              Icons.local_pharmacy_sharp,
              color: Color.fromRGBO(110, 206, 242, 1),
            ),
            title: const Text("Pharmacy List"),
            onTap: () => Get.to(const MapsPage()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              color: Color.fromRGBO(3, 65, 114, 1),
            ),
            title: const Text("Account"),
            onTap: () => Get.to(AccountInfo()),
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
