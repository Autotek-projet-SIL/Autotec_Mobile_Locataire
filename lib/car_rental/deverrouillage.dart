import 'dart:async';

import 'package:autotec/car_rental/sliding_uo_panel2.dart';
import 'package:autotec/models/location.dart';
import 'package:autotec/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';

import '../components/raised_button.dart';
import '../models/rest_api.dart';

class DeverrouillageScreen extends StatefulWidget {
  final CarLocation location;
  const DeverrouillageScreen({Key? key, required this.location})
      : super(key: key);

  @override
  _DeverrouillageScreenState createState() => _DeverrouillageScreenState();
}

class _DeverrouillageScreenState extends State<DeverrouillageScreen> {


 /* Timer? timer;
    @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
      
      //TODO ecouter le cham
      if (distance < 100) {                  
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeverrouillageScreen(
                location: widget.location,
              ),
            ),
          );
        }
        /* if (deverrouillage == 20) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeverrouillageScreen(
                location: widget.location,
              ),
            ),
          );
        }*/
      });
    });
    super.initState();
  }*/

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
          SizedBox(
              width: size.width * 0.6,
              child: CustomRaisedButton(
                  text: "Deverrouiller",
                  color: const Color.fromRGBO(27, 146, 164, 0.7),
                  textColor: Colors.white,
                  press: () => {
                        //TODO update the car in firebase with the user id (locatair)
                        //TODO ecouter le champ deverrouiller jusqua qu'il devient a vrai than push the new screen 
                        //TODO change the state to trajet 
                        //TODO in the end of this we get the starting time of the rental
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackingScreen2(
                                destinationLocation: LatLng(
                                    widget.location.latitude_arrive!,
                                    widget.location
                                        .longitude_arrive!), // LatLng(123123123, 1231231),
                                carid: "carid",
                                location : widget.location),
                          ),
                        ),
                        //TODO keep listening to the car's deverrouillage value in firebase when it's true set the car's locatair id to the user cridentials .uid
                       listenDeverrouiallage(context),
                      })),
        ]),
      ),
    );
  }

  void listenDeverrouiallage(BuildContext context) {
    var db = FirebaseFirestore.instance;
    final docRef =
        db.collection('CarLocation').doc(widget.location.car!.numeroChasis);
    docRef.snapshots().listen(
      (event) async {
        print("current data: ${event.data()}");
        if (event["deverrouiller"]) {
          //TODO la voiture est deverrouiller donc on doit updater la bd

          //TODO  set uid a user cridentials.uid
          await UserCredentials.refresh();
          final data = {'locataire_uid': UserCredentials.uid};
          db
              .collection('CarLocation')
              .doc(widget.location.car!.numeroChasis)
              .set(data, SetOptions(merge: true));
          Api.updateLocationState("trajet", widget.location.id!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackingScreen2(
                  destinationLocation: LatLng(
                      widget.location.latitude_arrive!,
                      widget.location
                          .longitude_arrive!), // LatLng(123123123, 1231231),
                  carid: widget.location.car!.numeroChasis,
                  location: widget.location),
            ),
          );
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }
}
