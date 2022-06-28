import 'dart:async';
import 'dart:convert';
import 'package:autotec/car_rental/sliding_uo_panel2.dart';
import 'package:autotec/models/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../components/raised_button.dart';
import '../components/text_field.dart';
import '../components/text_field_password.dart';
import '../models/rest_api.dart';

class DeverrouillageScreen extends StatefulWidget {
  final CarLocation location;

  const DeverrouillageScreen({Key? key, required this.location})
      : super(key: key);

  @override
  _DeverrouillageScreenState createState() => _DeverrouillageScreenState();
}

class _DeverrouillageScreenState extends State<DeverrouillageScreen> {
  final _nomController = TextEditingController();
  final _passwordController = TextEditingController();
  String mdp = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Votre voiture est arrivé",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          Center(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CustomTextField(
                      hintText: " Votre nom",
                      validationMode: AutovalidateMode.onUserInteraction,
                      controler: _nomController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFieldPassword(
                      hintText: " Votre mot de passe",
                      onChanged: (value) {},
                      validationMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordController,
                      validator: (value) {
                        return value != null && value.length < 6
                            ? "Enter min. 6 characters"
                            : null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(height: size.height * 0.06),
                ],
              ),
            ),
          ),
          SizedBox(
              width: size.width * 0.6,
              child: CustomRaisedButton(
                  text: "Deverrouiller",
                  color: const Color.fromRGBO(27, 146, 164, 0.7),
                  textColor: Colors.white,
                  press: () => {
                        deverrouillage(),
                      })),
        ]),
      ),
    );
  }

  Future<void> deverrouillage() async {
    final response = await Api.getUserPassword();
    var userInfo = jsonDecode(response.body);
    String mdp = userInfo[0]["mot_de_passe"];
    if (mdp.toString() == _passwordController.text) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackingScreen2(
              destinationLocation: LatLng(widget.location.latitude_arrive!,
                  widget.location.longitude_arrive!),
              carid: widget.location.car!.numeroChasis,
              location: widget.location),
        ),
      );
      var db = FirebaseFirestore.instance;
      final docRef =
          db.collection('CarLocation').doc(widget.location.car!.numeroChasis);
      final data = {'nom_locataire': _nomController.text};
      docRef.set(data, SetOptions(merge: true));
    }
  }
}
