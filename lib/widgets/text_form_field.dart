import 'package:flutter/material.dart';
class CustomTextForm extends StatelessWidget {
  final String hintText;
  final double height;
  const CustomTextForm({super.key,required this.hintText,required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Giving Custom Height to the Form Field 
      height: height,
      child: TextFormField(
        decoration:  InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText
        ),
      ),
    );
  }
}