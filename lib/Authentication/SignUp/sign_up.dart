// ignore_for_file: deprecated_member_use, unused_field

import 'package:autotec/Authentication/SignUp/sign_up2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:autotec/components/text_field.dart';
import 'package:autotec/components/text_field_digits.dart';
import 'package:autotec/models/user_data.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _form1Key = GlobalKey<FormState>();
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
      motDePasse: "",
      numeroTelephone: numeroTelephoneController.text,
    );
    if (_form1Key.currentState != null && _form1Key.currentState!.validate()) {
      debugPrint("Form Validated");
      // _signupFormKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUp2(user: user),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                Center(
                  child: Form(
                    key: _form1Key,
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

                        SizedBox(height: size.height * 0.06),
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
                              if (_form1Key.currentState!.validate()) {
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