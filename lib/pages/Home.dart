import 'package:chit_chat/models/userModel.dart';
import 'package:chit_chat/pages/Users.dart';
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
    return Scaffold(
    
      appBar: AppBar(
        actions: [
           Padding(
            padding:  const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                
                _auth.signOut();
              },
              child:const Icon(Icons.logout,color: Colors.white,)),
          ),
        ],
        title:const  Center(child:  Text("ChitChat",style: TextStyle(color: Colors.white),)),
        elevation: 0,
        backgroundColor: Colors.grey.shade800,
        leading: IconButton(onPressed: (){}, icon:const Icon(Icons.menu_rounded,color: Colors.white,)),
      ),
      backgroundColor: Colors.white12,
      body: _buildUserList());
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
          return const CircularProgressIndicator(
            color: Colors.green,
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) {
                return _buildUserListItem(doc, context);
              })
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

    if (_auth.currentUser!.email != data['email'].toString()) {
      String UsrName = data['usrname'];
      return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 20,
        child: ListTile(
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
                tileColor: Colors.grey.shade800,
                
            title: Text(data['usrname'].toString(),style: const TextStyle(color: Colors.white),),
          
            leading: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                      child: Text(
                    UsrName[0].toUpperCase(),
                    style:const  TextStyle(color: Colors.black, fontSize: 25),
                  ))),
            subtitle: data['Last Message'] !=null? Text(data['Last Message'].toString(),style: const TextStyle(color: Colors.white),) : const Text(""),
           trailing: data['LastMessageTime']!=null?Text(data['LastMessageTime'].toString(),style: const TextStyle(color: Colors.white),):
           const Text(""),
            onTap: () {
              // On click passed the user's UID to chat page for chatting or for other purposes.
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ChatPage(receiverUserEmail:data['email'] 
                    ,receiverUserID: data['uid'],Receivername: data['usrname'],profileImg: data['profilePic'].toString(),
                    LastMessageTime: data['LastMessageTime'],
                    ),
                   
                  ));
                   print(data['usrname']);
                   print(data['profilePic']);
            },
          ),
      ),
    );
    }
    return Container();
  }


 
}
