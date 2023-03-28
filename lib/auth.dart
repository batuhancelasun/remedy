import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// batucanaaaa
//asfasfasf
class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUser(String name, String surname, String tc,
      String kanGrubu, String gender, String email, String password) async {
    var user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("Person").doc(user.user?.uid).set({
      'name': name,
      'surName': surname,
      'email': email,
      'idNumber': tc,
      'kanGrubu': kanGrubu,
      'gender': gender,
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
