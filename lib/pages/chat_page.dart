import 'package:chit_chat/pages/Home.dart';
import 'package:chit_chat/services/Chat/chat_service.dart';
import 'package:chit_chat/widgets/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String? receiverUserEmail;
  final String? receiverUserID;

  ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService? _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                },
                child: const Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                )),
            title: Text(
              widget.receiverUserEmail!,
            )),

        // UI for Messages

        body: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildMessageInput(),
          ],
        ));
  }

// Build Message List
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>  (
      stream: _chatService!
          .getMessage(widget.receiverUserID.toString(), _auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Text("Error" + snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.green,
          );
        }

        // return ListTile(
        //   title: Text(snapshot[''].toString),
        //   subtitle: Text(snapshot.data!['Message'].toString()) ,
        // );
        return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageitem(document))
                .toList(),);
      },
    );
  }

// Build Message item

  Widget _buildMessageitem(DocumentSnapshot documentsnapshot) {
    Map<String, dynamic> data = documentsnapshot.data() as Map<String, dynamic>;

    // Align the Messages to Right if the sender is the current user  , other wise to the left

    // var alignment = (data['receiverID'] == FirebaseAuth.instance.currentUser!.uid)
    //     ? Alignment.centerLeft
    //     : Alignment.centerRight;

    return Column(
      children: [
        // receiver
 data['receiverID'] == _auth.currentUser!.uid ? Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 6,right: 100,left: 6),
           
            
            alignment: Alignment.center,
            decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(20)
            ),
            child: SizedBox(
              
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                   textDirection: TextDirection.ltr,
                  data['Message'],style: TextStyle(color: Colors.white),),
              )),
          ),
  
        ],
      ),
    )
    :
  // Sender
     Container(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          Container(
             padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 6,right: 6,left: 100),
            alignment: Alignment.center,
            decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20)
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(data['Message'],style: TextStyle(color: Colors.white),)),
          ),
  
        ],
      ),
    )
      ],
    );
    
    
   

    
  }
// Build Message input

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: CustomTextForm(
                hintText: "Type Message",
                height: 100,
                controller: _messageController,
                obscureText: false)),
        IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(Icons.send))
      ],
    );
  }

  // Method for Sending Messages
  void sendMessage() async {
    print(widget.receiverUserID.toString());
    if (_messageController.text.isNotEmpty) {
      await _chatService!.sendMessage(
          widget.receiverUserID!, _messageController.text.toString().trim());

      // Clear the text controller after sending the message

      _messageController.clear();
    }
  }
}
