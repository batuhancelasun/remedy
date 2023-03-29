import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:remedy/auth.dart';
import 'package:remedy/pages/home_page.dart';
import 'package:remedy/pages/register_page.dart';

import 'package:remedy/pages/onboarding_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

String? errorMessage = '';
Auth _authService = Auth();

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signIn() async {
    try {
      await _authService.signIn(
          _controllerEmail.text, _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Remedy');
  }

  Widget _mailText(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget passwordText(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        signIn();
      },
      child: const Text('Login'),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      onPressed: () {
        Get.to(const RegisterPage());
      },
      child: const Text('Register'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.help_outline_rounded),
              onPressed: () => Get.to(OnBoardingScreen()),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            _mailText('Email', _controllerEmail),
            passwordText('Password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            _registerButton(),
            SizedBox(
              height: 300.0,
              child: Image.asset("images/remedy.png"),
            )
          ],
        ),
      ),
    );
  }
}
