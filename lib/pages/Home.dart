import 'package:chit_chat/models/userModel.dart';
import 'package:chit_chat/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUserList());
  }

  // Build List of Users except for the current logged in User..
  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Eror");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.green,
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc, context))
              .toList(),
        );
      },
    );
  }

  // Build User List Item

  Widget _buildUserListItem(
      DocumentSnapshot documentsnapshot, BuildContext context) {
    // We create a Map with name data and get data from document Snapshot and convert it to Map.
    Map<String, dynamic> data = documentsnapshot.data() as Map<String, dynamic>;
    // We check if the current Login user email is not equal to those emails which are in data map then show others users email in list tile

    // if (_auth.currentUser!.email != data['email'].toString()) {
    //   return ListTile(
    //     title: Text(data['email']),
    //     onTap: () {
    //       // On click passed the user's UID to chat page for chatting or for other purposes.
    //       Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) =>  ChatPage(receiverUserEmail:data['email'] ,receiverUserID: data['uid'],),
               
    //           ));
    //            print(data['email']);
    //     },
    //   );
    // }
    return   ListTile(
        title: Text(data['usrname']),
        onTap: () {
          // On click passed the user's UID to chat page for chatting or for other purposes.
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  ChatPage(receiverUserEmail:data['email'] ,receiverUserID: data['uid'],),
               
              ));
               print(data['usrname']);
        },
      );
  }
}
