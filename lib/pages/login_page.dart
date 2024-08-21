import 'package:chit_chat/models/userModel.dart';
import 'package:chit_chat/pages/Home.dart';
import 'package:chit_chat/pages/signupPage.dart';
import 'package:chit_chat/services/user_check.dart';
import 'package:chit_chat/widgets/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // We create this Global for setting Up the Validation on From Fields
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Creating GetIt Instance
  // GetIt _getIt = GetIt.instance;
  // Create Auth Service Class Instance
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fixing the Pixel Error Issue
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

// Complete UI Will be created in _buildUI method
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
            "Hi Welcome Back!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          Text(
            "Hello Again, you've been missed",
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
      height: MediaQuery.sizeOf(context).height * 0.40,
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
        onPressed: () async {
          if (_loginFormKey.currentState!.validate()) {LoginUser(_emailController.text.toString().trim(),_passwordController.text.toString().trim());}
        },
        // Getting the Default Primary Color for Button
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          "Login",
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
          const Text("Don't have an account? ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SingUp(),
                  ));
            },
            child: const Text(
              "SignUp Now",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  LoginUser(String email, String password) async{
    UserCredential? credential;
    credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const usrChecking() ,));

        // When the User is Login then using Credential we took the UID 
          var UID = credential!.user!.uid;

        // Then we create DocumentSnapshot because we will fetch the Data for this specific user from FireStore database.
          // userDataSnapshot -> This will get complete data using UID and save it

          DocumentSnapshot userDataSnapShot = await   FirebaseFirestore.instance.collection('Users').doc(UID).get();
          // Then we will call our userModel and inside that we call the function .fromMap which mean that this will function
          // will data in map format and save it in Map form and we know data is in string and dynamic so we just set the map type.
              //userDatasnapshot will return object and  then we will convert it to map
          UserModel userModel = UserModel.fromMap(userDataSnapShot.data() as Map<String,dynamic>);
        })
        .onError(
          (error, stackTrace) {
            print(error);
          },
        );
  }
}
