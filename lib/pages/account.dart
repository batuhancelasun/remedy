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

  //We have created TextEditingControllers to control the current user's data.
  //We need to control the data from Firestore & Firebase to show this user information to the user and let them edit their informations.

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

  //We created firebaseUser info function to get current user's data from firestore

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

  //This function let you update your name on firebase via elevated button press

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

  //This function let you update your last name on firebase via elevated button press
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

  //This function let you update your id number on firebase via elevated button press
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

  //This function let you update your gender on firebase via elevated button press

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

  //This function let you update your e-mail on firebase via elevated button press
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

  //This function let you update your blood type on firebase via elevated button press
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

  //This function let you choose your blood type from dropdown menu and update it with the elevated button above.
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

  //This function let you choose your gender from dropdown menu and update it with the elevated button above.
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

  //We created the Container model to show user information on the screen.
  //This model let us show the informations more easily.
  //We won't write the code block again and again with the help of this model.
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

  //We created this model to update the user informations from Firestore & Firebase easily.
  //We don't need to call the update again and again in our main widget.
  Widget _buildUpdateInfo() {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //We use TextFormField to update user name information.
            //This is the model of the TextFormField.
            //When user enter the new name information we call the _updateName() function to update information from database.
            Column(
              children: [
                TextFormField(
                  controller: _inputNameController,
                  onChanged: (value) => _updateName,
                  decoration:
                      InputDecoration(label: Text("Current: " "$myName")),
                ),
                _updateName()
              ],
            ),
            //We use TextFormField to update user last name information.
            //This is the model of the TextFormField.
            //When user enter the new last name information we call the _updateLastName() function to update information from database.
            Column(
              children: [
                TextFormField(
                  controller: _inputLastNameController,
                  onChanged: (value) => _updateLastName,
                  decoration:
                      InputDecoration(label: Text("Current: " "$myLastName")),
                ),
                _updateLastName()
              ],
            ),
            //We use TextFormField to update user e-mail information.
            //This is the model of the TextFormField.
            //When user enter the new e-mail information we call the _updateEmail() function to update information from database.
            Column(
              children: [
                TextFormField(
                  controller: _inputEmailController,
                  onChanged: (value) => _updateEmail,
                  decoration:
                      InputDecoration(label: Text("Current: " "$myEmail")),
                ),
                _updateEmail()
              ],
            ),
            //We use TextFormField to update user id number information.
            //This is the model of the TextFormField.
            //When user enter the new id number information we call the _updateIdNumber() function to update information from database.
            Column(
              children: [
                TextFormField(
                  controller: _inputIdNumberController,
                  onChanged: (value) => _updateIdNumber,
                  decoration:
                      InputDecoration(label: Text("Current: " "$myIdNumber")),
                ),
                _updateIdNumber()
              ],
            ),
            //We use 2 different functions to update user gender information.
            //This is the model of the update section.
            //First we call _updateDropdownGender to let user select the new gender information
            //then we call the _updateGender() function to update information from database.
            Column(
              children: [_updateDropdownGender(), _updateGender()],
            ),
            //We use 2 different functions to update user blood type information.
            //This is the model of the update section.
            //First we call _updateDropdownBloodType to let user select the new blood type information
            //then we call the _updateBloodType() function to update information from database.
            Column(
              children: [_updateDropdownBloodType(), _updateBloodType()],
            ),
          ],
        ),
      ),
    );
  }

  //When updating the gender section we control the option with this bool variable.
  bool isMale = false;
  //With this bool variable we control if the editing is on or not.
  bool edit = false;

  //If edit button has clicked and editing is on, user will see this model to edit their informations.
  //We use our _buildSingleContainer function to edit informations easily.
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

  //With this function we let users to sign out from account page.
  Future<void> signOut() async {
    await Auth().signOut();
    Get.to(const WidgetTree());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        //Button is changing depends on the edit is true or false.
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
                          //Profile picture will set to the user depends on their gender.
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
                    //Edit Profile button show or hide
                    edit == false
                        ? ElevatedButton(
                            onPressed: () {
                              setState(() {
                                edit = true;
                              });
                            },
                            child: const Text("Edit Profile"))
                        : Container()
                  ],
                ),
              ),
            );
          }),
    );
  }
}
