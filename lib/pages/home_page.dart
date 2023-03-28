import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remedy/auth.dart';
import 'package:remedy/pages/google_maps.dart';
import 'package:remedy/pages/home_page_new.dart';
import 'package:remedy/pages/medicine_description.dart';
import 'package:get/get.dart';
import 'package:remedy/widget_tree.dart';

import 'onboarding_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    Get.to(const WidgetTree());
  }

  Widget _title() {
    return const Text('Remedy');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _merhaba() {
    return const Text('Merhaba!');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  Widget _goToDescription() {
    return ElevatedButton(
        onPressed: () => Get.to(const MedicineDescription()),
        child: const Text("Go To Description List"));
  }

  Widget _goToGPS() {
    return ElevatedButton(
        onPressed: () => Get.to(const MapsPage()), child: const Text("GPS"));
  }

  Widget _goToOnBoardingScreen() {
    return ElevatedButton(
      onPressed: () => Get.to(OnBoardingScreen()),
      child: const Text("Go To OnBoarding Screen."),
    );
  }

  Widget _goToNewHomePage() {
    return ElevatedButton(
        onPressed: () => Get.to(NewHomePage()),
        child: const Text("Go To New Home Page."));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu), //Menü ayarlanacak.
          onPressed: () => Get.to(HomePage()),
        ),
        centerTitle: true,
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _merhaba(),
            _userUid(),
            _signOutButton(),
            _goToDescription(),
            _goToGPS(),
            _goToOnBoardingScreen(),
            _goToNewHomePage(),
          ],
        ),
      ),
    );
  }
}
