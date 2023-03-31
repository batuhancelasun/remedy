import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import '../getDatas/datas/user_credentials.dart';
import '../widget_tree.dart';
import 'home_page.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final User? currentUser = Auth().currentUser;

  final FirebaseFirestore _firestoreAuth = FirebaseFirestore.instance;

  final TextEditingController name = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController idnumber = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController bloodtype = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _inputNameController = TextEditingController();
  final TextEditingController _inputLastNameController =
      TextEditingController();
  final TextEditingController _inputEmailController = TextEditingController();
  final TextEditingController _inputIdNumberController =
      TextEditingController();
  final TextEditingController _inputGenderController = TextEditingController();
  final TextEditingController _inputBloodTypeController =
      TextEditingController();

  // ignore: body_might_complete_normally_nullable
  Future<UserCredentials?> userProfile() async {
    final docUser = _firestoreAuth.collection('Person').doc(currentUser?.uid);
    final snaphot = await docUser.get();

    if (snaphot.exists) {
      return UserCredentials.fromJson(snaphot.data()!);
    }
  }

  String? myEmail;
  String? myName;
  String? myBloodType;
  String? myLastName;
  String? myGender;
  String? myIdNumber;

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
          myBloodType = ds.data()!['bloodType'];
          myLastName = ds.data()!['surName'];
          myGender = ds.data()!['gender'];
          myIdNumber = ds.data()!['idNumber'];
        },
      );
    }
  }

  Widget _updateName() {
    return ElevatedButton(
      child: const Text('Update Your First Name'),
      onPressed: () {
        var docUser = _firestoreAuth.collection('Person').doc(currentUser?.uid);
        docUser.update(
          {
            'name': _inputNameController.text,
          },
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("First Name updated!")));
      },
    );
  }

  Widget _updateLastName() {
    return ElevatedButton(
      child: const Text('Update Your Last Name'),
      onPressed: () {
        var docUser = _firestoreAuth.collection('Person').doc(currentUser?.uid);
        docUser.update(
          {
            'surName': _inputLastNameController.text,
          },
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Last Name updated!")));
      },
    );
  }

  Widget _updateIdNumber() {
    return ElevatedButton(
      child: const Text('Update Your ID Number'),
      onPressed: () {
        var docUser = _firestoreAuth.collection('Person').doc(currentUser?.uid);
        docUser.update(
          {
            'idNumber': _inputIdNumberController.text,
          },
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("ID Number updated!")));
      },
    );
  }

  Widget _updateGender() {
    return ElevatedButton(
      child: const Text('Update Your Gender'),
      onPressed: () {
        setState(() {
          var docUser =
              _firestoreAuth.collection('Person').doc(currentUser?.uid);
          docUser.update(
            {
              'gender': _inputGenderController.text,
            },
          );
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Gender updated!")));
      },
    );
  }

  Widget _updateEmail() {
    return ElevatedButton(
      child: const Text('Update Your E-mail Address'),
      onPressed: () {
        var docUser = _firestoreAuth.collection('Person').doc(currentUser?.uid);
        docUser.update(
          {
            'email': _inputEmailController.text,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("E-mail Adress updated!")));
      },
    );
  }

  Widget _updateBloodType() {
    return ElevatedButton(
      child: const Text('Update Your Blood Type'),
      onPressed: () {
        var docUser = _firestoreAuth.collection('Person').doc(currentUser?.uid);
        docUser.update(
          {
            'bloodType': _inputBloodTypeController.text,
          },
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Blood Type updated!")));
      },
    );
  }

  String? newBloodType;
  Widget _updateDropdownBloodType() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => DropdownButton(
        icon: const Padding(
          padding: EdgeInsets.only(left: 84.5),
          child: Icon(Icons.arrow_circle_down),
        ),
        onChanged: (String? newValue) {
          _inputBloodTypeController.text = newValue ?? '';
          setState(() {
            newBloodType = newValue!;
          });
        },
        hint: Text("$myBloodType"),
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
        value: newBloodType,
      ),
    );
  }

  String? newGender;
  Widget _updateDropdownGender() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => DropdownButton(
        icon: const Padding(
          padding: EdgeInsets.only(left: 84.5),
          child: Icon(Icons.arrow_circle_down),
        ),
        onChanged: (String? newValue) {
          _inputGenderController.text = newValue ?? '';
          _updateGender();
          setState(() {
            newGender = newValue!;
          });
        },
        hint: Text("$myGender"),
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
        value: newGender,
      ),
    );
  }

  Widget _buildSingleContainer(
      {required String startText, required String endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: edit == false
                ? const Color.fromRGBO(110, 206, 242, 1)
                : const Color.fromRGBO(82, 222, 160, 1),
            borderRadius: BorderRadius.circular(30)),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: const TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              endText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateInfo() {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                TextFormField(
                  controller: _inputNameController,
                  onChanged: (value) => _updateName,
                  decoration:
                      InputDecoration(label: Text("Current: " + "$myName")),
                ),
                _updateName()
              ],
            ),
            Column(
              children: [
                TextFormField(
                  controller: _inputLastNameController,
                  onChanged: (value) => _updateLastName,
                  decoration:
                      InputDecoration(label: Text("Current: " + "$myLastName")),
                ),
                _updateLastName()
              ],
            ),
            Column(
              children: [
                TextFormField(
                  controller: _inputEmailController,
                  onChanged: (value) => _updateEmail,
                  decoration:
                      InputDecoration(label: Text("Current: " + "$myEmail")),
                ),
                _updateEmail()
              ],
            ),
            Column(
              children: [
                TextFormField(
                  controller: _inputIdNumberController,
                  onChanged: (value) => _updateIdNumber,
                  decoration:
                      InputDecoration(label: Text("Current: " + "$myIdNumber")),
                ),
                _updateIdNumber()
              ],
            ),
            Column(
              children: [_updateDropdownGender(), _updateGender()],
            ),
            Column(
              children: [_updateDropdownBloodType(), _updateBloodType()],
            ),
          ],
        ),
      ),
    );
  }

  bool isMale = false;
  bool edit = false;

  Widget _buildContainerPart() {
    if (myGender == "Male") {
      isMale = true;
    } else {
      isMale = false;
    }
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(startText: "First Name: ", endText: "$myName"),
          _buildSingleContainer(
              startText: "Last Name: ", endText: "$myLastName"),
          _buildSingleContainer(startText: "E-mail: ", endText: "$myEmail"),
          _buildSingleContainer(
              startText: "ID Number: ", endText: "$myIdNumber"),
          _buildSingleContainer(
              startText: "Blood Type: ", endText: "$myBloodType"),
          _buildSingleContainer(startText: "Gender: ", endText: "$myGender"),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await Auth().signOut();
    Get.to(const WidgetTree());
  }

  bool centerCircle = false;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    FirebaseFirestore.instance
        .collection("Person")
        .doc(currentUser?.uid)
        .update({
      'name': name.text,
      'surName': lastname.text,
      'email': email.text,
      'idNumber': idnumber.text,
      'bloodType': bloodtype.text,
      'gender': gender.text,
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: edit == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
                // ignore: prefer_const_constructors
                icon: Icon(Icons.close_rounded),
              )
            : IconButton(
                onPressed: () => Get.to(const MyHomePage()),
                icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          edit == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      edit = false;
                    });
                  },
                  icon: const Icon(Icons.check_rounded))
              : IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () {
                    signOut();
                  },
                )
        ],
        title: const Text("Account Information"),
      ),
      body: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Container(
                height: 552,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 130,
                          width: double.infinity,
                          child: isMale == true
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const CircleAvatar(
                                      maxRadius: 65,
                                      backgroundImage: AssetImage(
                                          "images/male_profile_picture.png"),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const CircleAvatar(
                                      maxRadius: 65,
                                      backgroundImage: AssetImage(
                                          "images/female_profile_picture.png"),
                                    ),
                                  ],
                                ),
                        ),
                        edit == true
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                            .viewPadding
                                            .left +
                                        220,
                                    top: MediaQuery.of(context)
                                            .viewPadding
                                            .left +
                                        110),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 374,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              child: edit == true
                                  ? _buildUpdateInfo()
                                  : _buildContainerPart(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    edit == false
                        ? ElevatedButton(
                            onPressed: () {
                              setState(() {
                                edit = true;
                              });
                            },
                            child: Text("Edit Profile"))
                        : Container()
                  ],
                ),
              ),
            );
          }),
    );
  }
}
