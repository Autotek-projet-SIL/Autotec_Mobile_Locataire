// ignore_for_file: deprecated_member_use

import 'selfie.dart';
import 'package:flutter/material.dart';
import 'package:autotec/components/text_field_password.dart';
import 'package:autotec/models/user_data.dart';

class SignUp2 extends StatefulWidget {
  UserData user;
  SignUp2({required this.user, Key? key}) : super(key: key);
  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController mdpConfirmController = TextEditingController();
  dataNavigation(BuildContext context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      debugPrint("Form Validated");
      // _signupFormKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Selfie(u: widget.user),
        ),
      );
    } else {
      debugPrint("Form Not Validated");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.01),
                Image.asset(
                  'assets/logo.png',
                  width: 350,
                ),
                SizedBox(height: size.height * 0.06),
                const Text(
                  "S'inscrire pour continuer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.06),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.03),
                        TextFieldPassword(
                          controller: _passwordController,
                          hintText: "Mot de passe",
                          validationMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value != null && value.length < 6
                                ? "Enter min. 6 characters"
                                : null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextFieldPassword(
                          controller: mdpConfirmController,
                          hintText: "Confirmer votre Mot de passe",
                          validationMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value != null && value.length < 6
                                ? "Verifier votre mot de passe"
                                : null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        SizedBox(height: size.height * 0.03),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: RaisedButton(
                            color: const Color.fromRGBO(27, 146, 164, 0.7),
                            hoverColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 14),
                            child: const Text(
                              "continue",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget.user.motDePasse =
                                    _passwordController.text;
                                dataNavigation(context);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
