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

  _getCurrentLocation() {
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

 void _onItemTapped(int index) async{

   setState(() async{
     _selectedIndex = index;
     if (_selectedIndex==3){
       context.read<AuthBloc>().add(SignOutRequested());
     }
     if(_selectedIndex == 2) {

     }
   });

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await userCredentials.refresh();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPlacesScreen()),
          );
        },
        backgroundColor: const Color.fromRGBO(27, 146, 164,1),
        child: Icon(Icons.car_rental_outlined, color: Colors.white,size: 30,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        elevation: 5.0,
        currentIndex:_selectedIndex ,
        selectedLabelStyle: const TextStyle(color: Color.fromRGBO(27, 146, 164, 0.7),),
        showUnselectedLabels: true,
        items:  <BottomNavigationBarItem> [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.grey,),
            activeIcon:Icon(Icons.home_outlined, color: Color.fromRGBO(27, 146, 164, 0.7),) ,
            label: 'Accueil',

          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.grey,),
            activeIcon:Icon(Icons.history, color: Color.fromRGBO(27, 146, 164, 0.7),) ,
            label: 'Historique',

          ),
         const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none, color: Colors.grey,),
            activeIcon:Icon(Icons.notifications_none, color: Color.fromRGBO(27, 146, 164, 0.7),) ,
            label: 'Location',

          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.grey,),
            activeIcon:Icon(Icons.person_outlined, color: Color.fromRGBO(27, 146, 164, 0.7),) ,
            label: 'Profile',


          ),
        ],
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