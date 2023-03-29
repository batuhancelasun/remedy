import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({super.key});

  final User? user = Auth().currentUser;

  Widget get _userUid {
    return Text(user?.email ?? 'User email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account Information"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(children: [
            SizedBox(
              width: 128,
              height: 128,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                    image: AssetImage("images/male_profile_picture.png"),
                  )),
            ),
            const SizedBox(height: 10),
            const Text(
              "Tahir Furkan Sarıdiken",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              user?.email ?? 'User email',
            ),
            const SizedBox(height: 20),
            // ignore: prefer_const_constructors
            SizedBox(
              width: 200,
              child: const ElevatedButton(
                  onPressed: null,
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(color: Color.fromRGBO(208, 242, 255, 1)),
                  ),
                  style: ButtonStyle(
                      //backgroundColor: Colors.amberAccent,
                      )),
            )
          ]),
        ),
      ),
    );
  }
}
