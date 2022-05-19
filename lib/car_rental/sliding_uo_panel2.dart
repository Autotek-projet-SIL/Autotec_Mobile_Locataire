import 'dart:async';
import 'dart:ui';
import 'package:autotec/car_rental/real_time_tracking2.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/location.dart';


class Distance {
  static double distance = 0.0;
  static int time = 00;
}

class TrackingScreen2 extends StatefulWidget {
  final LatLng destinationLocation;
  final String carid;
  final CarLocation location;
  const TrackingScreen2(
      {Key? key,
      required this.destinationLocation,
      required this.carid,
      required this.location})
      : super(key: key);

  @override
  _TrackingScreen2State createState() => _TrackingScreen2State();
}

class _TrackingScreen2State extends State<TrackingScreen2> {
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;
  double distance = 0.0;
  int cpt = 0;
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        distance = Distance.distance;
        cpt++;
      if (distance < 20) {
        //TODO change the state to payment
        //call end location and give it time 
        //calcule de la facture 
        //TODO get la facture 
      }       
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
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
            body: MyMap2(
              destinationLocation: LatLng(widget.location.latitude_arrive!,
                  widget.location.longitude_arrive!),
              carId: widget.location.car!.numeroChasis,
              userId:
                  "USER", // we use it to get the car's location from firebase

              //LatLng(36.713819, 3.174251), // client location , it's fixed at first
            ),
            panelBuilder: (sc) => _panel(),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
          ),

          // the fab
          Positioned(
            right: 10.0,
            top: 40.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                //  go to the support page²
              },
              label: const Text('demande de support',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color.fromRGBO(27, 146, 164, 0.7))),
              icon: const Icon(Icons.support_agent,
                  color: Color.fromRGBO(27, 146, 164, 0.7)),
              backgroundColor: Colors.white,
            ),
          ),
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
                    ((Distance.distance / 80) > 1)
                        ? (Distance.distance ~/ 80).toStringAsFixed(0) +
                            "h" +
                            " " +
                            (((Distance.distance / 80) -
                                        (Distance.distance ~/ 80)) *
                                    60)
                                .toStringAsFixed(0) +
                            " min restantes"
                        : (Distance.distance * 60 ~/ 80).toStringAsFixed(0) +
                            " minutes restantes",
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
                    Distance.distance.toStringAsFixed(2) + " km pour arriver",
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
                leading: const Icon(Icons.countertops,
                    color: Color.fromRGBO(27, 146, 164, 0.7)),
                title: Text(Distance.distance.toStringAsFixed(2) + "1231 DZD",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.black)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: ListTile(
                leading: Icon(Icons.directions_car,
                    color: Color.fromRGBO(27, 146, 164, 0.7)),
                title: Text("909-163-09",
                    style: TextStyle(
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
