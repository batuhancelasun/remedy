import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import '../widget_tree.dart';

class GetRegisterData extends StatefulWidget {
  const GetRegisterData({super.key});

  @override
  State<GetRegisterData> createState() => _GetRegisterDataState();
}

Auth _authService = Auth();
String? errorMessage = '';

class _GetRegisterDataState extends State<GetRegisterData> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurName = TextEditingController();
  final TextEditingController _controllerIdNumber = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();
  final TextEditingController _controllerBloodType = TextEditingController();

  late bool _passwordVisible = false;

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

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
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

  Widget _userIdText(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  String? selectedBloodType;
  Widget _bloodTypeButton(
    String title,
    TextEditingController controller,
  ) {
    return DropdownButton(
      icon: const Padding(
        padding: EdgeInsets.only(left: 84.5),
        child: Icon(Icons.arrow_circle_down),
      ),
      onChanged: (String? newValue) {
        controller.text = newValue ?? '';
        setState(
          () {
            selectedBloodType = newValue!;
          },
        );
      },
      hint: const Text('Please choose your blood type.'),
      items: const [
        DropdownMenuItem<String>(
          value: 'A+',
          child: Text('A+ (A Rh Positive)'),
        ),
        DropdownMenuItem<String>(
          value: 'A-',
          child: Text('A- (A Rh Negative)'),
        ),
        DropdownMenuItem<String>(
          value: 'B+',
          child: Text('B+ (B Rh Positive)'),
        ),
        DropdownMenuItem<String>(
          value: 'B-',
          child: Text('B- (B Rh Negative)'),
        ),
        DropdownMenuItem<String>(
          value: '0+',
          child: Text('0+ (0 Rh Positive)'),
        ),
        DropdownMenuItem<String>(
          value: '0-',
          child: Text('0- (0 Rh Negative)'),
        ),
        DropdownMenuItem<String>(
          value: 'AB+',
          child: Text('AB+ (AB Rh Positive)'),
        ),
        DropdownMenuItem<String>(
          value: 'AB-',
          child: Text('AB- (AB Rh Negative)'),
        ),
      ].toList(),
      value: selectedBloodType,
    );
  }

  String? selectedGender;
  Widget _genderButton(
    TextEditingController controller,
  ) {
    return DropdownButton(
      icon: const Padding(
        padding: EdgeInsets.only(left: 110),
        child: Icon(Icons.arrow_circle_down),
      ),
      onChanged: (String? newValue) {
        controller.text = newValue ?? '';
        setState(
          () {
            selectedGender = newValue!;
          },
        );
      },
      hint: const Text('Please choose your gender.'),
      items: const [
        DropdownMenuItem<String>(
          value: 'Male',
          child: Text('Male'),
        ),
        DropdownMenuItem<String>(
          value: 'Female',
          child: Text('Female'),
        ),
        DropdownMenuItem<String>(
          value: 'Other',
          child: Text('Other'),
        ),
      ].toList(),
      value: selectedGender,
    );
  }

  Widget _passwordText(
    String title,
    TextEditingController controller,
  ) {
    return TextFormField(
      obscureText: !_passwordVisible,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        hintText: "Please enter your password.",
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(
              () {
                _passwordVisible = !_passwordVisible;
              },
            );
          },
        ),
      ),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      onPressed: () {
        register();
      },
      child: const Text('Register'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _nameText('First Name', _controllerName),
        _surNameText('Last Name', _controllerSurName),
        _userIdText("ID Number", _controllerIdNumber),
        _mailText('Email', _controllerEmail),
        _genderButton(_controllerGender),
        _bloodTypeButton('Blood Type', _controllerBloodType),
        _passwordText('Password', _controllerPassword),
        _registerButton(),
        _errorMessage(),
      ],
    );
  }
}
