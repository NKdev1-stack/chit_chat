class ChatRoomModel {


      

    String? chatroomid;
    // Participants mean two peoples who are chatting
    List<String>? participants;


  //##### JSON Serialization 
  /*
  You can generate Constructor and Json Serialiazation using Extension Dart Class code generator
  but you can also create it manually so first create a Default constructor, then .from Map Function
  and .toMap function

  from map: (take values from map and save in variable )
  to map: (shift variables value to map)
   */ 
    
    // Its a Default Constructor
  ChatRoomModel({
    required this.chatroomid,
    required this.participants,
  });

  // .From Map Function

  ChatRoomModel.fromMap(Map<String,dynamic> map){
    chatroomid: map['chatoomid'];
    participants: map['participants'];
  }
  
  //. .to Map Function
  Map <String, dynamic> toMap() {
    return{
      'chatroomid':chatroomid,
      'participants': participants
    };  
  }


}
