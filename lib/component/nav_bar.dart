import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              "Tahir Furkan Sarıdiken",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            accountEmail: Text("furkan@saridiken.com"),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/navbar_background.png"),
              fit: BoxFit.cover,
            )),
          )
        ],
      ),
    );
  }
}
