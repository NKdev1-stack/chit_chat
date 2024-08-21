// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Messagemodel {
  // Variables...
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String Message;
  final Timestamp timestamp;

// Constructor...
  Messagemodel(
      {required this.senderID,
      required this.senderEmail,
      required this.receiverID,
      required this.Message,
      required this.timestamp});


// To map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'Message': Message,
      'timestamp': timestamp,
    };
  }

// From map
  factory Messagemodel.fromMap(Map<String, dynamic> map) {
    return Messagemodel(
      senderID: ['senderID'] as String,
      senderEmail: map['senderEmail'] as String,
      receiverID: ['receiverID'] as String,
      Message: map['Message'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }

  
}
