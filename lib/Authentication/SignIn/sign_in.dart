// ignore_for_file: deprecated_member_use
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autotec/components/text_field.dart';
import 'package:autotec/components/text_field_password.dart';
import 'package:autotec/bloc/auth_bloc.dart';
import 'package:autotec/models/user_data.dart';
import 'package:autotec/models/rest_api.dart';
import '../SignUp/sign_up.dart';
import 'package:autotec/car_rental/home_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
             Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Map()));


          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              // Showing the sign in form if the user is not authenticated
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 350,
                        ),
                        SizedBox(height: size.height * 0.06),
                        const Text(
                          "Se connecter pour continuer",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: size.height * 0.06),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  hintText: " Votre email",
                                  controler: _emailController,
                                  validationMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value != null &&
                                            !EmailValidator.validate(value)
                                        ? 'Enter a  valid email'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(height: size.height * 0.03),
                                TextFieldPassword(
                                  hintText: " Votre mot de passe",
                                  controller: _passwordController,
                                  onChanged: (value) {},
                                  validationMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value != null && value.length < 6
                                        ? "Enter min. 6 characters"
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(height: size.height * 0.06),
                                FractionallySizedBox(
                                  widthFactor: 1,
                                  child: RaisedButton(
                                    color:  const Color.fromRGBO(27, 146, 164, 0.7),
                                    hoverColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 14),
                                    child: const Text(
                                      "Se connecter",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    onPressed: () {
                                      _authenticateWithEmailAndPassword(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.06),
                       const Text(
                          "Vous n'avez pas de compte? ",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
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
                              "S'inscrire",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            onPressed: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()),
                              );

                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

}
