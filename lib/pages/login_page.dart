import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import 'onboarding_screen.dart';
import 'register_page.dart';

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

  late bool _passwordVisible = true;

  Future<void> signIn() async {
    try {
      await _authService.signIn(
          _controllerEmail.text, _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(
        () {
          errorMessage = e.message;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  Widget passwordText(
    String title,
    TextEditingController controller,
  ) {
    return TextFormField(
      obscureText: _passwordVisible,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        hintText: "Please enter your password.",
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
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
      decoration: InputDecoration(
          labelText: title, hintText: "Please enter your email address."),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm? $errorMessage');
  }

  Widget _logInButton() {
    return ElevatedButton(
      onPressed: () {
        signIn();
      },
      child: const Text('Login'),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      onPressed: () => Get.to(
        const RegisterPage(),
      ),
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
            _logInButton(),
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
