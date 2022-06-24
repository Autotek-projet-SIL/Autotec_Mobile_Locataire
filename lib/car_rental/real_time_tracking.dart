// ignore_for_file: avoid_print, prefer_final_fields

import 'package:autotec/models/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import './sliding_up_panel.dart';

class MyMap extends StatefulWidget {
  final String carId;
  final String userId;
  final LatLng destinationLocation;
  final CarLocation location;

  const MyMap({
    Key? key,
    required this.carId,
    required this.userId,
    required this.destinationLocation,
    required this.location,
  }) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyCYFQXP0t1dUWtl9V4xm73lt-l_nQQIkcw";
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;

  @override
  void initState() {
    setSourceAndDestinationIcons();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('CarLocation').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (_added) {
            mymap(snapshot);
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: false,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: {
              Marker(
                infoWindow: InfoWindow(title: "car on the way ", onTap: () {}),
                onTap: () {},
                position: LatLng(
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.carId)['latitude'],
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.carId)['longitude'],
                ),
                markerId: const MarkerId('SourcePin'),
                icon: sourceIcon!,
              ),
              Marker(
                  infoWindow: InfoWindow(
                      title: " name of the user ",
                      snippet: "waiting for car",
                      onTap: () {}),
                  position: widget.destinationLocation,
                  markerId: const MarkerId('destPin'),
                  icon: destinationIcon!),
            },
            polylines: _polylines,
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
                  setPolylines(snapshot);
                },
              );
            },
          );
        },
      ),
    );
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = BitmapDescriptor.defaultMarker;
    //await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 9.2, size: Size(12, 12)),'assets/car-placeholder.png');

    destinationIcon = BitmapDescriptor.defaultMarker;
    //await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 9.2, size: Size(12, 12)),'assets/user-pin.png');
  }

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
    } else {
      print(result.errorMessage);
    }
    double totalDistance = 0;
    /*  for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }*/
    print(totalDistance);

    setState(() async {
      Polyline polyline = Polyline(
          polylineId: const PolylineId("poly"),
          color: const Color.fromRGBO(27, 146, 164, 0.7),
          width: 10,
          visible: true,
          points: polylineCoordinates);
      _polylines.add(polyline);

      Distance.distance = await calculateDistance(
          snapshot.data!.docs
              .singleWhere((element) => element.id == widget.carId)['latitude'],
          snapshot.data!.docs.singleWhere(
              (element) => element.id == widget.carId)['longitude'],
          widget.destinationLocation.latitude,
          widget.destinationLocation.longitude);
    });
  }

  Future<double> calculateDistance(
      double lat1, double lon1, double lat2, double lon2) async {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  /*
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));*/

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
            zoom: 12.47),
      ),
    );
  }
}
