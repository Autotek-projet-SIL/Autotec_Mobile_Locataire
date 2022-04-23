// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

/*To do

1 - the slider 
2 - the distance 
3 - the remaining time 
4 - fix ui 
5 - the localisation pin 
6 - localization pin informations on click
7 - fixe my time sheet

 */

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

  // Set<Marker> _markers = {};
  //Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyD1ZzI2O9bqUhQdwsPaUNrp81wtpvxZvzY";
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;

  late LatLng source;

  @override
  void initState() {
    //source = widget.sourceLocation;
    setSourceAndDestinationIcons();
    super.initState();
  }

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
                onTap: () {},
                infoWindow: InfoWindow(
                    title: "car is moving ", snippet: "snippet", onTap: () {}),
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
                  position: widget.destinationLocation,
                  markerId: const MarkerId('destPin'),
                  icon: destinationIcon!),
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
                  _controller.setMapStyle(Utils.mapStyles);
                  _added = true;
                  //  setPolylines(snapshot);
                },
              );
            },
          );

          /*  DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  height: 200,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Column(children: const[
                       Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("car name"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Remaining time"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Remaining distance"),
                      )
                      ],),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset('assets/Car.png',height: 100, width: 100,),  
                      ),
                     
                    ],
                  ),
                );
              },
            ),*/
        },
      ),
    );
  }

  void setSourceAndDestinationIcons() async {
    /*   sourceIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(0.01, 0.01)),
      'assets/location-map--car-pin.png',
    );*/
    sourceIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    destinationIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  }

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

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
