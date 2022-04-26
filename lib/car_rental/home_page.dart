import 'package:autotec/bloc/auth_bloc.dart';
import 'package:autotec/models/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/rest_api.dart';
import 'search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autotec/Authentication/first_screens/home.dart';



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
    _getCurrentLocation();
  }

  _getCurrentLocation() async{
   /*
    final Position _currentlocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
        setState(() {
          latitude = _currentlocation.latitude;
          longitude = _currentlocation.longitude;
        });
        print("***************");
        print(latitude);
        print(longitude);

    */
  }

  late GoogleMapController mapController;


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(latitude,longitude), 13));

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

          await  _getCurrentLocation();


          mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(latitude,longitude), 14));
        },
        backgroundColor: const Color.fromRGBO(27, 146, 164,1),
        child: Icon(Icons.navigation_outlined, color: Colors.white,size: 30,),
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
                  await userCredentials.refresh();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPlacesScreen()),
                  );
                  },
                icon: Icon(Icons.car_rental_outlined, color: Colors.grey,size: 30),
              tooltip: 'rent a car',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 5, 50, 5),
            child: IconButton(
              onPressed: (){
                //TODO navigate to profil
              },
              icon: Icon(Icons.person_outlined, color: Colors.grey,size: 30),
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
                initialCameraPosition: CameraPosition(
                  target: LatLng(36.7762, 3.05997),
                  zoom: 13.0,
                ),
              ),

            ]
        ),),

    );
  }
}