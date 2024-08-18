import 'package:chit_chat/models/userModel.dart';
import 'package:chit_chat/pages/login_page.dart';
import 'package:chit_chat/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI());
  }

  // / Complete UI Will be created in _buildUI method
  Widget _buildUI() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      child: Column(
        // Calling all different Widgets there
        children: [_headerText(), _loginForm(), _createAccountLink_Signup()],
      ),
    ));
  }

// For the Header Text
  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi Welcome!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          Text(
            "Register Your Account",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // For login Form

  Widget _loginForm() {
    return Container(
      // * 0.40 means it will take 40% of screen height
      height: MediaQuery.sizeOf(context).height * 0.60,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.05),
      // Under the Form Widget we will use the Custom Text Form Fields
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextForm(
              controller: _emailController,
              obscureText: false,
              hintText: "Email",
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            CustomTextForm(
              controller: _passwordController,
              obscureText: true,
              hintText: "Password",
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            CustomTextForm(
              controller: _confirmpasswordController,
              obscureText: true,
              hintText: "Confirm Password",
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            CustomTextForm(
              controller: _fullnameController,
              obscureText: false,
              hintText: "FullName",
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            _signupButton()
          ],
        ),
      ),
    );
  }

// For Signup Button

  Widget _signupButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          if (_loginFormKey.currentState!.validate()) {
            signUp(_emailController.text.toString().trim(),
                _passwordController.text.toString().trim());
          }
        },
        // Getting the Default Primary Color for Button
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          "Signup ",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // For SignUp Text (Create Account Link widget)

  Widget _createAccountLink_Signup() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text("Already have an account? ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text(
              "Login Now",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
  // Functions for Value checking and Signup

  // not required because we already use form to check is values are entered or not...

  // void checkValues(){

  //   // .trim will remove the extra spaces
  //   String email = _emailController.text.toString().trim();
  //   String Password = _passwordController.text.toString().trim();
  //   String CPassword = _confirmpasswordController.text.toString().trim();
  //   String FullName = _fullnameController .text.toString().trim();

  // }

  void signUp(String Email, String Password) async {
              // Whenever we send data into firebase for authentication it return the UserCredential which contain all data about user.

    UserCredential? Credential; // ? it mean it may b null in or not in future
    try {

       Credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: Email, password: Password);
    }on FirebaseAuthException catch (ex) {
      print(ex.message.toString());
    }
  // Check is Credential is not empty save data into Database (Firestore or Realtime)
    if(Credential != null){
      // Getting the UID of Current User from Credential variable
      String uid =Credential.user!.uid.toString();
        // calling userModel to send data to FirebaseFirestore.... 
        UserModel userModel= UserModel(uid: uid, fullName:_fullnameController.text.toString().trim(), email: Credential.user!.email.toString().trim(), profilePic: "");
      // UserModel is not a map but there is a function serializaiton fromMap, .tomap will help us they will change this data to Map and then we will send this to database
    //.set will take Map or data in map form so we directly pass the Map in it
      await FirebaseFirestore.instance.collection("Users").doc(uid).set(
        // .toMap is the function in the UserModel which will change all data of userModel to map and then we are sending it to FirebaseFirestore Database.

        userModel.toMap()
      )

      // .then mean when account is created
    .then((value){
        print("Account Created");
    }); 


    }
  }
}
