import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _authApp = FirebaseAuth.instance;
  User? curUser;

  @override
  void initState() {
    super.initState();
    getCurUser();
  }

  void getCurUser() {
    try {
      final user = _authApp.currentUser;
      if (user != null) {
        curUser = user;
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        actions: [
          IconButton(
            onPressed: () {
              _authApp.signOut();
            },
            icon: const Icon(Icons.logout)
          )
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your email is ",
              style: TextStyle(
                fontSize: 20
              ),
            ),
            const SizedBox(height: 20),
            Text(curUser!.email!,
              style: const TextStyle(
                fontSize: 20
              ),
            )
          ],
        ),
      ),
    );
  }
}