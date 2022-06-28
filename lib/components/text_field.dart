import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controler;
  final AutovalidateMode? validationMode;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.onChanged,
    this.validator,
    this.controler,
    this.validationMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controler,
      validator: validator,
      autovalidateMode: validationMode,
      onChanged: onChanged,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
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
        contentPadding: const EdgeInsets.all(14.0),
      ),
    );
  }
}
