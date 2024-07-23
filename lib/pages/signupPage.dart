
import 'package:chit_chat/pages/login_page.dart';
import 'package:chit_chat/widgets/text_form_field.dart';
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
  TextEditingController _bioController = TextEditingController();
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
              controller: _bioController,
              obscureText: false,
              hintText: "Bio",
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
        onPressed: ()async {
          if (_loginFormKey.currentState!.validate()) {
          }
        },
        // Getting the Default Primary Color for Button
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          "Singup ",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // For SignUp Text (Create Account Link widget)

  Widget _createAccountLink_Signup() {
    return  Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        const  Text("Already have an account? ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
            },
            child:const Text(
              "Login Now",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
