import 'package:assignment_8/ChatPage.dart';
import 'package:assignment_8/RegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _authApp = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Password"
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () async {
              try {
                final curUser =
                    await _authApp.signInWithEmailAndPassword(
                        email: email, password: password);

                if (curUser.user != null) {
                  _formKey.currentState!.reset();
                  if (!mounted) return;

                  }
                } catch(e) {
                  print(e);
                }
              },
              child: const Text("Enter")),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("If you did not register, "),
                TextButton(
                  child: const Text("Register your email"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                  },
                )
              ],
            )
          ],
        )
      ),
    );
  }
}