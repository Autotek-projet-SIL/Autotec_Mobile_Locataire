import 'package:autotec/car_rental/sliding_uo_panel2.dart';
import 'package:autotec/models/location.dart';
import 'package:autotec/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';

import '../components/raised_button.dart';

class DeverrouillageScreen extends StatefulWidget {
  final CarLocation location;
  const DeverrouillageScreen({Key? key, required this.location})
      : super(key: key);

  @override
  _DeverrouillageScreenState createState() => _DeverrouillageScreenState();
}

class _DeverrouillageScreenState extends State<DeverrouillageScreen> {
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
      (event) {
        print("current data: ${event.data()}");
        if (event["deverrouiller"]) {
          //TODO la voiture est deverrouiller donc on doit updater la bd

          //TODO  set uid a user cridentials.uid
          UserCredentials.refresh();
          final data = {'locataire_uid': UserCredentials.uid};
          db
              .collection('CarLocation')
              .doc(widget.location.car!.numeroChasis)
              .set(data, SetOptions(merge: true));
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
