import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'components/app_bar.dart';


class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
 late double latitude ;
 late double longitude ;


  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        print(position.latitude);
        print(position.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  late GoogleMapController mapController;


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(latitude,longitude), 13));

  }

 int _selectedIndex = 0;
 static const TextStyle optionStyle =
 TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
 static const List<Widget> _widgetOptions = <Widget>[
   //home page
   // Historique(), // historique page
   // Aide(), // demande du support page
   // Profile(), // profil page
 ];

 void _onItemTapped(int index) {

   setState(() {
     _selectedIndex = index;

   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5.0,
        currentIndex:_selectedIndex ,
        selectedLabelStyle: const TextStyle(color: Color.fromRGBO(27, 146, 164, 0.7),),
        showUnselectedLabels: true,
        items:  <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.grey,),
            activeIcon:Icon(Icons.home_outlined, color: Color.fromRGBO(27, 146, 164, 0.7),) ,
            label: 'Accueil',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental_outlined, color: Colors.grey,),
            activeIcon:Icon(Icons.car_rental_outlined, color: Color.fromRGBO(27, 146, 164, 0.7),) ,
            label: 'Location',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.grey,),
            activeIcon:Icon(Icons.history, color: Color.fromRGBO(27, 146, 164, 0.7),) ,
            label: 'Historique',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.grey,),
            activeIcon:Icon(Icons.person_outlined, color: Color.fromRGBO(27, 146, 164, 0.7),) ,
            label: 'Profile',

          ),
        ],
      ),
        body: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(36.7762, 3.05997),
                  zoom: 13.0,
                ),
              ),

            ]
        )
    );
  }
}