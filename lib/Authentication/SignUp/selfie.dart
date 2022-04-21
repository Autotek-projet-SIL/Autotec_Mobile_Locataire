// ignore_for_file: avoid_unnecessary_containers

//import 'package:autotec/Authentication/data/repositories/image_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:autotec/models/user_data.dart';
import 'package:autotec/components/raised_button.dart';


import 'identite.dart';

// ignore: must_be_immutable
class Selfie extends StatefulWidget {
  UserData u;

  Selfie({required this.u, Key? key}) : super(key: key);
  @override
  _SelfieState createState() => _SelfieState();
}

class _SelfieState extends State<Selfie> {
  bool isButtonActive = true;
  XFile? imageFile;
  //final Storage storage = Storage();
  final ImagePicker _picker = ImagePicker();

  _openGallery(BuildContext context) async {
    imageFile = (await _picker.pickImage(source: ImageSource.gallery));
   // final String fileName  = path.basename(imageFile!.path); 
   // final File filePath = File(imageFile!.path);
   // await storage.uploadFile(filePath.path, fileName).then((value) => debugPrint("done"));
    widget.u.photoSelfie = imageFile!.path;
    setState(() {});
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    imageFile = (await _picker.pickImage(source: ImageSource.camera));
    widget.u.photoSelfie = imageFile!.path;
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
        margin: const EdgeInsets.all(20),
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Veuillez prendre un selfie ou ajouter une photo de vous meme',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.06),
              _imageViewSelfie(),
              SizedBox(height: size.height * 0.06),
              CustomRaisedButton(
                text: "Selfie",
                press: () {
                  _showChoiceDialog(context);
                },
                color: Colors.white,
              ),
              SizedBox(height: size.height * 0.03),
              CustomRaisedButton(
                text: "Continuer",
                press: buttonActivated()
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Identite(
                              u: widget.u,
                            ),
                          ),
                        );
                      }
                    : null,
                color: const Color.fromRGBO(27, 146, 164, 0.7),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
