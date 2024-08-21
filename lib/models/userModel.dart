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
/*

These methods are essential for working with user data in Flutter applications, especially when interacting with databases or APIs.
 */

//The fromMap method is used to create a UserModel object from a Map.

  UserModel.fromMap(Map<String, dynamic> map) {
    uid:
    ['uid'];
    fullName:
    ['fullName'];
    email:
    ['email'];
    profilePic:
    ['profilePic'];
    username:
    [];
  }
// The toMap method is used to convert a UserModel object into a Map.

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'profilePic': profilePic,
      'usrname': username,
    };
  }
}
