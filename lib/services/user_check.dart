import 'package:chit_chat/models/userModel.dart';
import 'package:chit_chat/pages/Home.dart';
import 'package:chit_chat/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class usrChecking extends StatefulWidget {
  
  const usrChecking({super.key});

  @override

  State<usrChecking> createState() => _usrCheckingState();


}

class _usrCheckingState extends State<usrChecking> {

 
@override
 
  @override
  
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder:(context, snapshot) {
        if(snapshot.hasData){
          return  Home();
        }else{
          return const LoginPage();
        }
      },),
    );
  }
}