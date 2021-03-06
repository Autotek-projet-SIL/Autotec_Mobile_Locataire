// ignore_for_file: non_constant_identifier_names
import 'package:autotec/components/WBack.dart';
import 'package:autotec/profile/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:autotec/repositories/image_storage_repository.dart';
import 'package:autotec/models/user_data.dart';
import '../components/WraisedButton.dart';
import '../components/pop_ups.dart';
import '../components/text_field.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  final String image;
  final String nom;
  final String prenom;
  final String numTlph;
  final String mdp;
  final String recto_photo;
  final String verso_photo;
  const EditProfile({
    Key? key,
    required this.image,
    required this.nom,
    required this.prenom,
    required this.numTlph,
    required this.mdp,
    required this.recto_photo,
    required this.verso_photo,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? imageFile;
  String? imageChanged;
  bool loading = true;
  final ImagePicker _picker = ImagePicker();

  _openGallery(BuildContext context) async {
    imageFile = (await _picker.pickImage(source: ImageSource.gallery));
    imageChanged = imageFile!.path;
    setState(() {});
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    imageFile = (await _picker.pickImage(source: ImageSource.camera));
    imageChanged = imageFile!.path;
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

  void UpdateUser(String nom, String prenom, String num, String image) async {
    var res = await http.put(
      Uri.parse(
          'http://autotek-server.herokuapp.com/gestionprofils/modifier_locataire/${UserCredentials.uid}'),
      body: {
        "token": "${UserCredentials.token}",
        "id_sender": "${UserCredentials.uid}",
        "nom": nom,
        "prenom": prenom,
        "mot_de_passe": widget.mdp,
        "numero_telephone": num,
        "photo_identite_recto": "test",
        "photo_identite_verso": "test",
        "photo_selfie": image
      },
    );
    if (res.statusCode == 200) {
      setState(() {
        loading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
      );
    } 
  }

  Widget profileContainer(String text) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      height: 43,
      width: size.width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff2E9FB0),
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget labelContainer(String text) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.05,
        ),
        Text(text,
            style: TextStyle(
              color: const Color(0xff696969).withOpacity(0.7),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nomController =
        TextEditingController(text: widget.nom);
    TextEditingController prenomController =
        TextEditingController(text: widget.prenom);
    TextEditingController numController =
        TextEditingController(text: widget.numTlph);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [WidgetArrowBack()],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CircleAvatar(
                    radius: 85,
                    backgroundColor: const Color(0xff2E9FB0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 80,
                      backgroundImage: imageChanged == null
                          ? NetworkImage(widget.image)
                          : Image.file(File(imageFile!.path)).image,
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        iconSize: 40,
                        onPressed: () {
                          _showChoiceDialog(context);
                        },
                      ),
                    )),
                SizedBox(
                  height: size.height * 0.02,
                ),
                labelContainer("Nom :"),
                CustomTextField(
                  controler: nomController,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                labelContainer("Pr??nom :"),
                CustomTextField(
                  controler: prenomController,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                labelContainer("Numero de t??l??phone :"),
                CustomTextField(
                  onChanged: (value) {
                    numController.text = value;
                  },
                  hintText: " Numero de telephone ",
                  controler: numController,
                  validationMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value != null ? 'Enter a  valid number' : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                WidgetRaisedButton(
                  press: () async {
                    if (loading) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const EnCours();
                          });
                    }
                    FirebaseStorage.instance.refFromURL(widget.image).delete();

                    var imgUrl = await Storage.uploadFile(imageFile!.path,
                        "Selfies/" + widget.nom + " " + widget.prenom);
                    imageChanged = imgUrl;

                    UpdateUser(nomController.text, prenomController.text,
                        numController.text, imgUrl);
                  },
                  text: 'Modifier',
                  color: const Color(0xff2E9FB0),
                  textColor: Colors.white,
                ),
              ],
            )),
      ),
    );
  }
}
