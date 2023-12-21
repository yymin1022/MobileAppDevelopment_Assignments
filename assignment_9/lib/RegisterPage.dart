import 'package:assignment_9/SuccessRegister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _authApp = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  bool saving = false;
  String email = "";
  String password = "";
  String userName = "";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: saving,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Email"
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Password"
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "User Name"
                  ),
                  onChanged: (value) {
                    userName = value;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("Enter"),
                  onPressed: () async {
                    try {
                      setState(() {
                        saving = true;
                      });
                        final newUser =
                            await _authApp.createUserWithEmailAndPassword(
                                email: email, password: password);
                        await FirebaseFirestore.instance.collection("user").doc(newUser.user!.uid).set({
                          'userName': userName,
                          'email': email
                        });
                        if (newUser.user != null) {
                          _formKey.currentState!.reset();
                          if (!mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SuccessRegister()));
                        }
                        setState(() {
                          saving = false;
                        });
                      } catch(e) {
                        print(e);
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("If you already registered, "),
                    TextButton(
                      child: const Text("Login your email"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}