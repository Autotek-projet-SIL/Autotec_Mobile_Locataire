// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MyMap extends StatefulWidget {
  final String carId;
  final String userId;
  // final LatLng sourceLocation;
  final LatLng destinationLocation;
  const MyMap(
      {Key? key,
      required this.carId,
      required this.userId,
      //  required this.sourceLocation,
      required this.destinationLocation})
      : super(key: key);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyD1ZzI2O9bqUhQdwsPaUNrp81wtpvxZvzY";
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;

  late LatLng source;

/*  @override
  void initState() {
    //source = widget.sourceLocation;
   // setSourceAndDestinationIcons();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('location').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (_added) {
            mymap(snapshot);
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: {
              Marker(
                  position: LatLng(
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.carId)['latitude'],
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.carId)['longitude'],
                  ),
                  markerId: const MarkerId('SourcePin'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen)),
              Marker(
                  position: widget.destinationLocation,
                  markerId: const MarkerId('destPin'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue)),
            },
            //   polylines: _polylines,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.carId)['latitude'],
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.carId)['longitude'],
                ),
                zoom: 14.47),
            onMapCreated: (GoogleMapController controller) {
              setState(
                () {
                  _controller = controller;
                  _added = true;
                  //  setPolylines(snapshot);
                },
              );
            },
          );
        },
      ),
    );
  }

  /* void setSourceAndDestinationIcons() async {
    sourceIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    destinationIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
  }*/
/*
  setPolylines(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(
        snapshot.data!.docs
            .singleWhere((element) => element.id == widget.carId)['latitude'],
        snapshot.data!.docs
            .singleWhere((element) => element.id == widget.carId)['longitude'],
      ),
      PointLatLng(widget.destinationLocation.latitude,
          widget.destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    setState(() {
      Polyline polyline = Polyline(
          polylineId: const PolylineId("poly"),
          color: Colors.blue,
          width: 20,
          visible: true,
          points: polylineCoordinates);
      _polylines.add(polyline);
    });
  }
*/
  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.carId)['latitude'],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.carId)['longitude'],
            ),
            zoom: 14.47),
      ),
    );
  }
}