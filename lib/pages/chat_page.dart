import 'package:chit_chat/pages/Home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String? receiverUserEmail;
  final String? receiverUserID;
   ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));

            },
            child:const Icon(Icons.keyboard_backspace,color: Colors.black,)),
          title: Text(widget.receiverUserEmail!,)),
      
    );
  }
}