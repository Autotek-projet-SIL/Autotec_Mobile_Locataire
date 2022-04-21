// ignore_for_file: deprecated_member_use

import 'selfie.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:autotec/components/text_field.dart';
import 'package:autotec/components/text_field_digits.dart';
import 'package:autotec/components/text_field_password.dart';
import 'package:autotec/models/user_data.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController mdpConfirmController = TextEditingController();
  TextEditingController numeroTelephoneController = TextEditingController();

  dataNavigation(BuildContext context) {
    UserData user = UserData.m(
      id: "0",
      nom: firstNameController.text,
      prenom: lastNameController.text,
      email: _emailController.text,
      motDePasse: _passwordController.text,
      numeroTelephone: numeroTelephoneController.text,
    );
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      debugPrint("Form Validated");
      // _signupFormKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Selfie(u: user),
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
                SizedBox(height: size.height * 0.1),
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
                        CustomTextField(
                          hintText: "Nom",
                          validationMode: AutovalidateMode.onUserInteraction,
                          controler: firstNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        CustomTextField(
                          hintText: "Prénom",
                          validationMode: AutovalidateMode.onUserInteraction,
                          controler: lastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        CustomTextField(
                          hintText: " Votre email",
                          controler: _emailController,
                          validationMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value != null &&
                                    !EmailValidator.validate(value)
                                ? 'Enter a valid email'
                                : null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        WidgetTextfieldDigit(
                          hintText: "Numero de téléphone",
                          controller: numeroTelephoneController,
                          validationMode: AutovalidateMode.always,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 10) {
                              return 'le numero de telephone doit etre >10';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextFieldPassword (
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
                        TextFieldPassword (
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
                          child:RaisedButton(
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
                                dataNavigation(context);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}