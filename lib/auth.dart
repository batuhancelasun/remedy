import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//  This class is for our login, logout and register operations.

class Auth {
  //  variables to better readability.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestoreAuth = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //  We signin with firebase's "signInWithEmailAndPassword" method.
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //  We creating user with firebases's "createUserWithEmailAndPassword"
  //and also we store user's information (as below) and add that data to a firestore collection.
  Future<void> createUser(
    String name,
    String surname,
    String idNumber,
    String bloodType,
    String gender,
    String email,
    String password,
  ) async {
    var user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestoreAuth.collection("Person").doc(user.user?.uid).set(
      {
        'name': name,
        'surName': surname,
        'email': email,
        'idNumber': idNumber,
        'bloodType': bloodType,
        'gender': gender,
      },
    );
  }

  //  Sign out with firebase's "signOut" method.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
