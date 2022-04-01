import 'package:blog/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class providermodel extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isusersigin = false;

  bool get usersign_info => isusersigin;

  sigin(context, email, password) async {
    final UserCredential result = await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      isusersigin = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      return Future.value(value);
    });

    notifyListeners();
  }

  Singout() {
    isusersigin = false;
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
