class Messagemodel{


// This Model class is for Messages


String? sender; // A person who sent the message
String?  message; // A Messaage (chat) 
DateTime? messageSendTime; // Message sending Time
bool? seen; // is the Sender message is seen or not

Messagemodel({required this.sender, required this.message, required this.messageSendTime, required this.seen});


// Firebase sa data lein gy tu fromMap kry gein mean Firebase Map main data dy ga or aus Map sa object bnaye gein
// fromMap ki maddad sa Jaisy sender, Message, messageSendTime yh objects bnaye hain
Messagemodel.fromMap(Map<String,dynamic> map){

sender = map['sender'];
message = map['message'];
messageSendTime =map ['messageSendTime'];
seen = map['seen'];
  
}

// Or toMap ko use krty hoye haam Objects sa Map bnaye gein.
Map<String,dynamic> toMap() {
  return {

    'sender':sender,
    'message':message,
    'messageSendTime':messageSendTime,
    'seen':seen,
  };
}


}