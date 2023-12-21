import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("chat").orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return ChatElement(
                      isMe: docs[index]["uid"] == _authApp.currentUser!.uid,
                      userName: docs[index]["userName"],
                      text: docs[index]["text"],
                    );
                  },
                );
              },
            ),
          ),
          NewMessage()
        ]
      )
    );
  }
}

class ChatElement extends StatelessWidget {
  const ChatElement({super.key, this.isMe, this.userName, this.text});

  final bool? isMe;
  final String? userName;
  final String? text;

  @override
  Widget build(BuildContext context) {
    if(isMe!){
      return Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: ChatBubble(
          clipper: ChatBubbleClipper6(type: BubbleType.sendBubble),
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 20),
          backGroundColor: Colors.deepPurple,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  userName!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  )
                ),
                Text(
                  text!,
                  style: TextStyle(color: Colors.white),
                )
              ]
            ),
          ),
        ),
      );
    }else{
      return Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: ChatBubble(
          clipper: ChatBubbleClipper6(type: BubbleType.receiverBubble),
          backGroundColor: Color(0xffE7E7ED),
          margin: EdgeInsets.only(top: 20),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ),
                Text(
                  text!,
                  style: TextStyle(color: Colors.black),
                )
              ]
            ),
          )
        ),
      );
    }
  }
}

class NewMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String newMessage = "";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "New Message"
              ),
              onChanged: (value) {
                setState(() {
                  newMessage = value;
                });
              },
            ))),
        IconButton(
          color: Colors.deepPurple,
          onPressed: newMessage.trim().isEmpty ? null : () async {
            final curUser = FirebaseAuth.instance.currentUser;
            final curUserInfo = await FirebaseFirestore.instance.collection("user").doc(curUser!.uid).get();
            FirebaseFirestore.instance.collection("chat").add({
              "text": newMessage,
              "userName": curUserInfo.data()!["userName"],
              "timestamp": Timestamp.now(),
              "uid": curUser.uid
            });
          },
          icon: Icon(Icons.send)
        )
      ],
    );
  }
}