import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:remedy/auth.dart';
import 'package:remedy/widget_tree.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

//batubabav2
Auth _authService = Auth();
String? errorMessage = '';

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurName = TextEditingController();
  final TextEditingController _controllerIdNumber = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();
  final TextEditingController _controllerBloodType = TextEditingController();

  Future<void> register() async {
    try {
      await _authService.createUser(
          _controllerName.text,
          _controllerSurName.text,
          _controllerIdNumber.text,
          _controllerBloodType.text,
          _controllerGender.text,
          _controllerEmail.text,
          _controllerPassword.text);
      Get.to(const WidgetTree());
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
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

  Widget _nameText(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _surNameText(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _tcText(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _kanGrubuText(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _genderText(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _passwordText(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        register();
      },
      child: const Text('Register'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title(),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              _nameText('Name', _controllerName),
              _surNameText('Surname', _controllerSurName),
              _tcText("ID number", _controllerIdNumber),
              _mailText('Email', _controllerEmail),
              _genderText('Gender', _controllerGender),
              _kanGrubuText('Blood Type', _controllerBloodType),
              _passwordText('Password', _controllerPassword),
              _submitButton(),
              _errorMessage(),
            ],
          ),
        ));
  }
}
