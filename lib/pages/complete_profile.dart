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
              IconButton(onPressed: (){}, icon: const Icon( Icons.add_a_photo_sharp,
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
            _userNamecontroller,
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
}
