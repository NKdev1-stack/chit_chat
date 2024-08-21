import 'package:chit_chat/models/messageModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class ChatService extends ChangeNotifier {
  // Get instnace of Firebase Auth and Firestore database

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send Message

  Future<void> sendMessage(String receiverId, String message) async {
    // Get Current user Info
    final String CurrentuserID = _auth.currentUser!.uid;
    final String CurrentuserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new messsage.

    Messagemodel newMessageModel = Messagemodel(
        senderID: CurrentuserID,
        senderEmail: CurrentuserEmail,
        receiverID: receiverId,
        Message: message,
        timestamp: timestamp);

    // Construct Chat Room Id from Current user id and receiver id (sorted to ensure uniqueness)

    List<String> ids = [
      CurrentuserID,
      receiverId
    ]; // Create List and Add both sender and receiver id in it
    ids.sort();
    // Creating ChatRoom ID.
    String ChatRoomId = ids.join(
        "_"); // combine the ids into a single String to use as a Chat room id

    // add new message to database

    await _firestore
        .collection("chat_rooms")
        .doc(ChatRoomId)
        .collection('messages')
        .add(newMessageModel.toMap());
  }

  // Get Message

  Stream<QuerySnapshot> getMessage(String userID, String otherUserID) {
    // construct chat room id from user ids   (Sort it to check the Chat Room id is same or not (which was created using Sending messages) )

    List<String> ids = [userID, otherUserID];
    ids.sort();

    String ChatRoomID = ids.join("_");
    return _firestore
        .collection("chat_rooms")
        .doc(ChatRoomID)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
