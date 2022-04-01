import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class AuthService with ChangeNotifier {
  UserData? user;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signUp(
    String email,
    String password,
  ) async {
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore.instance.collection("users").doc(result.user!.uid).set({
        // "name": name,
        "email": email,
        "id": result.user!.uid,
      });
      FirebaseFirestore.instance.collection("users").doc(result.user!.uid).set({
        // "name": name,
        "email": email,
        "id": result.user!.uid,
      });
      print(email);
    } catch (e) {
      print("error");
    }
  }

  Future<void> signin(UserData userData) async {
    try {
      // final UserCredential result = await auth.signInWithEmailAndPassword(
      //     email: userData.email.toString(),
      //     password: userData.password.toString());
    } catch (e) {
      print("error");
    }
  }
}
