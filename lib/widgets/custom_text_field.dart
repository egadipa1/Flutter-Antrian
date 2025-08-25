import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText = '',
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade700)

        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900,width: 2)
        )
      ),
      validator: validator,
      style: TextStyle(fontSize: 16.0),
    );
  }
}