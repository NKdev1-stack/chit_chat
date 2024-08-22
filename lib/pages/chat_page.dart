import 'package:chit_chat/pages/Home.dart';
import 'package:chit_chat/services/Chat/chat_service.dart';
import 'package:chit_chat/widgets/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String? receiverUserEmail;
  final String? receiverUserID;
  final String? Receivername;
  final String? profileImg;
  final String? LastMessageTime;

  ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID,
      required this.Receivername,
      required this.LastMessageTime,
      required this.profileImg});

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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Icon(Icons.call,size: 30,color: Colors.white,),
            )
          ],
          leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
              },
              child: const Padding(
                padding:  EdgeInsets.only(left: 8, right: 900),
                child:  Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              )),
          flexibleSpace: ListTile(
            subtitle:  Text("Last Active "+widget.LastMessageTime.toString(),style:const TextStyle(color: Colors.white,fontSize: 12),),
              title:  Text(widget.Receivername.toString(),style: const TextStyle(color: Colors.white,),),
              leading: Container(
                  margin: EdgeInsets.only(left: 40),
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                      child: Text(
                    widget.Receivername![0].toString().toUpperCase(),
                    style:const  TextStyle(color: Colors.black, fontSize: 25),
                  ))))
                  
                  ,
          backgroundColor: Colors.grey.shade800,
        ),

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
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService!
          .getMessage(widget.receiverUserID.toString(), _auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Text("Error" + snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }

        // return ListTile(
        //   title: Text(snapshot[''].toString),
        //   subtitle: Text(snapshot.data!['Message'].toString()) ,
        // );
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageitem(document))
              .toList(),
        );
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
        data['receiverID'] == _auth.currentUser!.uid
            ? Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 6, right: 100, left: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                          child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          data['Message'],
                          style: TextStyle(color: Colors.white),
                        ),
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
                      margin: EdgeInsets.only(top: 6, right: 6, left: 100),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            data['Message'],
                            style: TextStyle(color: Colors.white),
                          )),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: CustomTextForm(
              hintText: "Type Message",
              height: 50,
              controller: _messageController,
              obscureText: false),
        )),
        Center(
          child: IconButton(
              onPressed: () {
                sendMessage();
              },
              icon: const Icon(
                Icons.send,
                size: 30,
              )),
        )
      ],
    );
  }

  // Method for Sending Messages
  void sendMessage() async {
    print(widget.receiverUserID.toString());
  DateTime now = DateTime.now();
String formattedTime = DateFormat('hh:mm a').format(now);
// print(now.hour.toString() + ":" + now.minute.toString() );
    if (_messageController.text.isNotEmpty) {
      if (_messageController.text.contains(
            "Sex",
          ) ||
          _messageController.text.contains("Adult") ||
          _messageController.text.contains(
            "18+",
          )) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("These Type of Messages are not Allowed ")));
      } else {
        await _chatService!.sendMessage(
            widget.receiverUserID!, _messageController.text.toString().trim());

        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        firebaseFirestore
            .collection("Users")
            .doc(_auth.currentUser!.uid)
            .update({
          'Last Message': _messageController.text.toString(),
          'LastMessageTime':formattedTime
              // Timenow.hour.toString() + ":" + Timenow.minute.toString()
            

        });
      }
      // Clear the text controller after sending the message

      _messageController.clear();
    }
  }
}
