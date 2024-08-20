import 'dart:io';

import 'package:chit_chat/models/userModel.dart';
import 'package:chit_chat/pages/Home.dart';
import 'package:chit_chat/widgets/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class CompleteProfile extends StatefulWidget {
  UserModel? userModel;


   CompleteProfile({super.key, required this.userModel});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController _userNamecontroller = TextEditingController();
  TextEditingController _biocController = TextEditingController();

  Uint8List imageFile = Uint8List(11000); // This variable will be used for Image store
  

    final GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.25,
                width: double.infinity,
                decoration:const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            "https://t3.ftcdn.net/jpg/05/28/86/66/360_F_528866602_aiVwnOnkooTrqo3MgicCf83SVVzt1Gnd.jpg"))),
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage:MemoryImage(imageFile)
              ),
              IconButton(onPressed: (){
                showPhotoOptions();
              }, icon: const Icon( Icons.add_a_photo_sharp,
                color: Colors.white,)),
            ],
          ),
          _formFields(),
        ],
      ),
    ));
  }

  Widget _formFields() {
    return Padding( 
      padding: const EdgeInsets.all(40),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            CustomTextForm(hintText: "UserName",
            height: MediaQuery.sizeOf(context).height *0.1, controller: 
            _userNamecontroller,
            obscureText: false),
            
            CustomTextForm(hintText: "Bio",
            height: MediaQuery.sizeOf(context).height *0.1, controller: 
            _biocController ,
            obscureText: false),
         
         _loginButton()
          ],
        
          
        ),
      ),
    );
  }

  // For Login Button

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: ()async {
          if (_loginFormKey.currentState!.validate()) {
            var downloadURL = await uploadImageToFirebaseStorage(imageFile);
 // Set the username , and profile pic in usermodel and then send this data to Firestore using UserModel other data will remain same in model just usrname, bio and profile pic will get updated


widget.userModel!.username = _userNamecontroller.text.toString().trim();
widget.userModel!.profilePic = downloadURL.toString();
            FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .set(widget.userModel!.toMap()).then((value) {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const Home(),));
            },); // this will again update the data automatically with some new or old data




          }
        },
        // Getting the Default Primary Color for Button
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          "Submit Now ",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }


  void showPhotoOptions(){
    // This Method will help us to Choose options for selecting image like Choose From camera or Gallery. And we will show this in Dialog bar

    showDialog(context: context, builder: (context){
      //.. We will return any widget there but now we will return Alert dialog..
      return   AlertDialog(
        title: const Text("Upload Profile Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){
                // Calling Select image method and passing source as a Gallery
                selectImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              title: const Text("Select from Gallery"),
              leading:const  Icon(Icons.image_sharp),
            ),
           const Divider(color: Colors.grey,),
            ListTile(
       // Calling Select image method and passing source as a Camera

              onTap: (){
                selectImage(ImageSource.camera);
                Navigator.pop(context);
              },
              title: const Text("Capture from Camera"),
              leading: const Icon(Icons.camera_alt_rounded),
            ) 
          ],
        ),
      );
    });

  }

  void selectImage(ImageSource source)async{
   

    Uint8List profileImg =await pickImage(source);
    setState(() {
      imageFile = profileImg;
    });



  }

   pickImage(ImageSource Imagesource)async{

    final ImagePicker _imagePicker = ImagePicker();
    XFile? file = await _imagePicker.pickImage(source: Imagesource);
    if(file!=null){
      return await file.readAsBytes();
    }else{
      print("No Image Selected");
    }

  }

  // Store image Into Firebase Storage...

   Future<String> uploadImageToFirebaseStorage(Uint8List img)async{

    FirebaseStorage _storage = FirebaseStorage.instance; // getting firebase storage instance
  Reference reference = _storage.ref("ProfileImages").child(FirebaseAuth.instance.currentUser!.uid.toString()); // Setup reference 

  UploadTask uploadTask =  reference.putData(img); // Add Image into the Reference of FirebaseAuth 

  // Getting download URL

  TaskSnapshot snapshot = await uploadTask; // we are waiting for uploadtask one it will finish it will return snapshot in TaskSnapshot

  String downloadURL = await snapshot.ref.getDownloadURL(); // getting download URL.
   

  return downloadURL; // return download URL for firestore Database...





  }

  
}
