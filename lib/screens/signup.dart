import 'dart:ffi';
import 'dart:math';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blog/provider/providermodel.dart';
import 'package:blog/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController password = TextEditingController();

  void login(context) {
    Provider.of<providermodel>(context, listen: false)
        .sigin(context, email.text.toString(), password.text.toString());
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    bool userstatus =
        Provider.of<providermodel>(context, listen: true).usersign_info;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Sign",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        "Up",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                              labelText: "enter your email",
                              hintText: "example@.com",
                              prefixIcon: Icon(Icons.mail)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: password,
                          decoration: const InputDecoration(
                              labelText: "enter password",
                              hintText: "....",
                              prefixIcon: Icon(Icons.lock)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              login(context);

                              // auth.createUserWithEmailAndPassword(
                              //     email: email.text.trim().toString(),
                              //     password: password.text.trim().toString());
                              // await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Home()));
                            },
                            child: const Text("Sign Up")),
                        Container(
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: userstatus ? Colors.green : Colors.red),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
