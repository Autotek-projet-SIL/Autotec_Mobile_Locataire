import 'dart:ui';

import 'package:autotec/car_rental/date_time_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:autotec/components/WBack.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

const kGoogleApiKey = 'AIzaSyDgZadIjr0Xgvmeo6JZp5CN18Cv8Vy8j0E';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(36.7762, 3.05997 ), zoom: 13.0);

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;

  late double latitude=0.0;
  late double longitude=0.0;

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: false)
        .then((Position position) {
      setState(() {
        this.latitude = position.latitude;
        this.longitude = position.longitude;
        print( position.latitude.toString());
        print(position.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,

      body: Stack(
        children: [
          Positioned(
           top: 10.0,
            left: 10.0,
            child: WidgetArrowBack(),
          ),
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            zoomControlsEnabled: false,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
         bottomsheet(),
        ],
      ),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'fr',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country,"DZ")]);

    setState(() {
      displayPrediction(p!,homeScaffoldKey.currentState);

    });
  }

  void onError(PlacesAutocompleteResponse response){
    homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {

    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(markerId: const MarkerId("1"),position: LatLng(lat, lng),infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 13.0));

  }

  Widget bottomsheet(){
    return  Positioned(
      bottom: 0.0,
      left: 0.0,
      child: Container(
          color: Colors.white,
          width: 380,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("point de depart", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MaterialButton(
                      color: Color.fromRGBO(27, 146, 164, 0.7),
                      textColor: Colors.white,
                      minWidth: 120,
                      onPressed: (){
                        _getCurrentLocation();
                        print("*******************");
                        print(this.latitude);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DateDebut( latitude:this.latitude,longitude: this.longitude,)),
                        );
                      },
                      child: const Text("votre position"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MaterialButton(
                      color: Color.fromRGBO(27, 146, 164, 0.7),
                      textColor: Colors.white,
                      minWidth: 120,
                      onPressed: _handlePressButton,
                      child: const Text("chercher un endroid"),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
