import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import "package:chat_app/screens/registration_screen.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore .instance;
  final _auth = FirebaseAuth.instance;
User? loggedInUser;
String? messagetext;
  @override
  void initState()
  {
   super.initState();
   getcurrentuser();
  }

void getcurrentuser() async
{
  final user=await _auth.currentUser;
  try{
  if(user!=null)
  {
    loggedInUser=user;
    // ignore: avoid_print
    print(loggedInUser!.email);
    
    // ignore: avoid_print
    // print(loggedInUser!.password);
  }
  }
  catch(e)
  {
    print(e);
  }
}

// void getmessages  () async
// {
//  final messages=await _firestore.collection('messages').get();
//  for(var message in messages.docs)
//  {
//   print(message.data);
//  }
// }

void messagestream() async
{
  await for(var snapshot in _firestore.collection('messages').snapshots())
  {
    print(snapshot);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                // Navigator.pop(context);
                messagestream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                       messagetext=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text': messagetext, 'sender': loggedInUser!.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
