import 'dart:async';
import 'dart:ui';
import 'package:autotec/car_rental/real_time_tracking.dart';
import 'package:autotec/components/raised_button.dart';
import 'package:autotec/models/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../models/rest_api.dart';

import '../models/user_data.dart';
import '../payment/payment_method.dart';
import 'deverrouillage.dart';

class Distance {
  static double distance = 0.0;
  static int time = 00;
}

class TrackingScreen extends StatefulWidget {
  final CarLocation location;
  final LatLng destinationLocation;
  final String carid;

  const TrackingScreen(
      {Key? key,
      required this.destinationLocation,
      required this.carid,
      required this.location})
      : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();

    listenFirestore();
  }
  listenFirestore() async {
    var db = FirebaseFirestore.instance;
    final docRef =
    db.collection('CarLocation').doc(widget.location.car!.numeroChasis);
    docRef.snapshots().listen((event) {
      if (event ["loue"] && event["arrive"]) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DeverrouillageScreen(location: widget.location)
            ));
        final data = {'arrive': false};
        docRef.set(data, SetOptions(merge: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.3;
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: MyMap(
              carId: widget.carid,
              userId: "USER",
              destinationLocation: widget.destinationLocation,
              location: widget.location,
            ),
            panelBuilder: (sc) => _panel(),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
          ),
          /*Positioned(
            right: 10.0,
            top: 40.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                //  go to the support page²
              },
              label: const Text('Demande de support',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color.fromRGBO(27, 146, 164, 0.7))),
              icon: const Icon(Icons.support_agent,
                  color: Color.fromRGBO(27, 146, 164, 0.7)),
              backgroundColor: Colors.white,
            ),
          ),*/
          Positioned(
              top: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.transparent,
                      )))),
        ],
      ),
    );
  }

  Widget _panel() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(" Détails du trajet",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(27, 146, 164, 0.7))),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ListTile(
                leading: const Icon(Icons.access_time_filled_sharp,
                    color: Color.fromRGBO(27, 146, 164, 0.7)),
                title: Text(
                    "minutes restantes",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.black)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ListTile(
                leading: const Icon(Icons.pin_drop_rounded,
                    color: Color.fromRGBO(27, 146, 164, 0.7)),
                title: Text(
                    Distance.distance.toStringAsFixed(2) +
                        " metres pour arriver",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.black)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ListTile(
                leading: const Icon(Icons.directions_car,
                    color: Color.fromRGBO(27, 146, 164, 0.7)),
                title: Text(widget.location.car!.numeroChasis,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.black)),
              ),
            ),
          ],
        ));
  }
}
