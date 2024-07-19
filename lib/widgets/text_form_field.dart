import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final double height;
  final obscureText;
  final TextEditingController controller;
  const CustomTextForm(
      {super.key, required this.hintText, required this.height,   required this.controller, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Giving Custom Height to the Form Field
      height: height,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (hintText.endsWith('l')) {
            if (value!.isEmpty) {
              return value.isEmpty ? 'Incorrect Email' : null;
            }
          } else if (hintText.endsWith('d')) {
            if (value!.isEmpty) {
              return value.isEmpty ? 'Incorrect Password' : null;
            }
          }
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(), hintText: hintText),
      ),
    );
  }
}
