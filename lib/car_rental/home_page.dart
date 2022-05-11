
// ignore_for_file: avoid_print, deprecated_member_use

import 'package:autotec/bloc/auth_bloc.dart';
import 'package:autotec/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autotec/Authentication/first_screens/home.dart';
import 'package:permission_handler/permission_handler.dart';


final scaffoldKey = GlobalKey<ScaffoldState>();

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
 late double latitude ;
 late double longitude ;
 late Position? _currentlocation ;
 @override
  void initState() {
    super.initState();
   // _getCurrentLocation();
  }

  _getCurrentLocation(){
     Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: false).then((Position position) {

      setState(() {
        _currentlocation = position;
      });
    }).catchError((e) {
      print(e);
    });

        setState(() {
          latitude = _currentlocation!.latitude;
          longitude = _currentlocation!.longitude;
        });
        print("***************");
        print(latitude);
        print(longitude);

  }

  late GoogleMapController mapController;


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(latitude,longitude), 13));

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if( await Permission.location.isGranted){

            if(await Permission.location.serviceStatus.isEnabled){

              _getCurrentLocation();
            }else{

              scaffoldKey.currentState!.showSnackBar(const SnackBar(content: Text("activer la localisation")));
            }
          }else{

            scaffoldKey.currentState!.showSnackBar(const SnackBar(content: Text("permission denied")));

            await [Permission.location,].request();
          }




          mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(latitude,longitude), 14));
        },
        backgroundColor: const Color.fromRGBO(27, 146, 164,1),
        child: const Icon(Icons.navigation_outlined, color: Colors.white,size: 30,),
      ),
    bottomNavigationBar: BottomAppBar(
      shape:const CircularNotchedRectangle(),

      color: Colors.white,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 5, 20, 5),
            child: IconButton(
                onPressed: ()async{
                  await UserCredentials.refresh();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPlacesScreen()),
                  );
                  },
                icon: const Icon(Icons.car_rental_outlined, color: Colors.grey,size: 30),
              tooltip: 'rent a car',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 5, 50, 5),
            child: IconButton(
              onPressed: (){
                //TODO navigate to profil


              },
              icon: const Icon(Icons.person_outlined, color: Colors.grey,size: 30),
              tooltip: 'open profil',
            ),
          ),



        ],
      ),
      notchMargin: 5,
    ),
      body: BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
    if (state is UnAuthenticated) {
    // Navigate to the sign in screen when the user Signs Out
    Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const Home()),
    (route) => false,
    );
    }
    },
        child:   Stack(
            children: <Widget>[
              GoogleMap(
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(36.7762, 3.05997),
                  zoom: 13.0,
                ),
              ),

            ]
        ),),

    );
  }
}