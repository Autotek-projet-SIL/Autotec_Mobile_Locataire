import 'package:flutter/material.dart';

class TextFieldPassword extends StatelessWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode? validationMode;
  const TextFieldPassword({
    Key? key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.validator,
    this.validationMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: validationMode,
      validator: validator,
      obscureText: true,
      onChanged: (value) {},
      cursorColor: const Color.fromRGBO(27, 146, 164, 1),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: const Icon(
          Icons.visibility,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.all(14.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 3, color: Color.fromRGBO(27, 146, 164, 1)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
