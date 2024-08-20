import 'dart:io';

import 'package:chit_chat/widgets/text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompleteProfile extends StatefulWidget {

  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController _userNamecontroller = TextEditingController();
  TextEditingController _biocController = TextEditingController();
  late File imageFile; // This variable will be used for Image store
  

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
            const  CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXOdZN9FwqzYqEL6SJa7uQNAFQAmepwBR3bg&s"),
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
      return  AlertDialog(
        title: const Text("Upload Profile Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Select from Gallery"),
              leading: IconButton(onPressed: (){}, icon: const Icon(Icons.image_sharp)),
            ),
           const Divider(color: Colors.grey,),
            ListTile(
              title: const Text("Capture from Camera"),
              leading: IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt_rounded)),
            ) 
          ],
        ),
      );
    });

  }

  void selectImage()async{
    // We will use this method for Selecting image
  }

  void cropImage()async{
    // We will use this method for Cropping image
  }  
}
