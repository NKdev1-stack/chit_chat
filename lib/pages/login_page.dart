import 'package:chit_chat/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextForm(
              hintText: "Enter Email",
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            CustomTextForm(
              hintText: "Enter Password",
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
        onPressed: () {},
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
    return const Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           Text("Don't have an account? ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
          Text("SignUp Now",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
        ],
      ),
    );
  }
}
