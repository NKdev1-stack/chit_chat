
class UserModel {

  String? uid;
  String? fullName;
  String? email;
  String? profilePic;
  String? username;
  
  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.profilePic,
    required this.username,
  });

  UserModel.fromMap(Map<String,dynamic> map){
    uid:['uid'];
    fullName:['fullName'];
    email:['email'];
    profilePic:['profilePic'];
    username:[];

  }

  Map <String, dynamic> toMap(){

    return {
      'uid':uid,
      'fullName':fullName,
      'email':email,
      'profilePic':profilePic,
      'usrname':username,
      

    };
  }

}
  

  