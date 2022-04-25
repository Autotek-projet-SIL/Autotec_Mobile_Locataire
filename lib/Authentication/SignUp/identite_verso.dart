// ignore_for_file: avoid_unnecessary_containers

import 'package:autotec/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:autotec/bloc/auth_bloc.dart';
import 'package:autotec/models/rest_api.dart';
import 'package:autotec/models/user_data.dart';
import '../../../components/raised_button.dart';
import 'package:autotec/car_rental/home_page.dart';
import '../Dashboard/dashboard.dart';
import 'package:autotec/repositories/image_storage_repository.dart';
// ignore: must_be_immutable
class Identite_verso extends StatefulWidget {
  UserData u;
  Identite_verso({required this.u, Key? key}) : super(key: key);
  @override
  _Identite_versoState createState() => _Identite_versoState();
}

class _Identite_versoState extends State<Identite_verso> {
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  bool isButtonActive = true;
  _openGallery(BuildContext context) async {
    imageFile = (await _picker.pickImage(source: ImageSource.gallery));
    setState(() {});
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    imageFile = (await _picker.pickImage(source: ImageSource.camera));
    setState(() {});
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text('Gallery'),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text('Camera'),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _imageViewSelfie() {
    if (imageFile == null) {
      return Container(
        margin: const EdgeInsets.all(20),
        width: 250,
        height: 250,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
              fit: BoxFit.fill),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(15),
        width: 400,
        height: 250,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: Image.file(File(imageFile!.path)).image, fit: BoxFit.fill),
        ),
      );
    }
  }

  bool buttonActivated() {
    if (imageFile == null) {
      return isButtonActive = false;
    } else {
      return isButtonActive = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the home screen if the user is authenticated
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Map(),
            ));

          }
          if (state is AuthError) {
            // Displaying the error message if the user is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            // Displaying the loading indicator while the user is signing up
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            // Displaying the sign up form if the user is not authenticated
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(23.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Veuillez prendre une photo de votre piece d'identité (verso)",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.06),
                    _imageViewSelfie(),
                    SizedBox(height: size.height * 0.06),
                    CustomRaisedButton(
                      text: "Prendre photo",
                      press: () {
                        _showChoiceDialog(context);
                      },
                      color: Colors.white,
                    ),
                    SizedBox(height: size.height * 0.03),
                    CustomRaisedButton(
                      text: "S'inscrire",
                      press: buttonActivated()
                          ? () async {
                        //uploading the image to storage
                        var id_url = await Storage.uploadFile(imageFile!.path,"Pièces identité Verso/"+widget.u.nom!+" "+widget.u.prenom!);
                        widget.u.photoIdentiteVerso = id_url ;

                        print(widget.u.photoIdentiteVerso);
                        //inscription firebase and REST API
                        await _createAccountWithEmailAndPassword(context);


                      } : null,
                      color: const Color.fromRGBO(27, 146, 164, 0.7),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<void> _createAccountWithEmailAndPassword(BuildContext context) async {
    BlocProvider.of<AuthBloc>(context).add(
      SignUpRequested(
        widget.u.email!,
        widget.u.motDePasse!,
        widget.u
      ),
    );
  }

}
