// ignore_for_file: deprecated_member_use

import 'package:autotec/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:autotec/models/Location.dart';

import 'cars_list.dart';
const kGoogleApiKey = 'AIzaSyDgZadIjr0Xgvmeo6JZp5CN18Cv8Vy8j0E';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}


class _SearchPlacesScreenState extends State<SearchPlacesScreen> {

  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(36.7762, 3.05997 ), zoom: 14.0);

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;

  late double latitude_dpr=0.0;
  late double longitude_dpr=0.0;

  late double latitude_arv = 0.0;
  late double longitude_arv = 0.0;

  bool depart = false;
  bool arrive = false;

  String depart_adr = "";
  String arrive_adr = "";
  String region = "";

  Future<Map<String, double>> _getCurrentLocation() async{
    double? lat;
    double? lng;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: false)
        .then((Position position) async{
          setState(() {
            lat = position.latitude;
            lng = position.longitude;

          });
    }).catchError((e) {
      print(e);
    });
    return {'latitude':lat!, 'longitude':lng!};
  }

  void _setMarker(String id, double lat, double lng){
    markersList.add(Marker(markerId:  MarkerId(id),position: LatLng(lat, lng),));
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }

 Future<String> _getAdress(double latitude, double longitude)async{
   final coordinates = Coordinates(latitude, longitude);
   var addresses = await Geocoder.local.findAddressesFromCoordinates(
       coordinates);
   var first = addresses.first;
   print('1. ${first.locality}, 2. ${first.adminArea}, 3. ${first.subLocality}, '
       '4. ${first.subAdminArea}, 5. ${first.addressLine}, 6. ${first.featureName},'
       '7, ${first.thoroughfare}, 8. ${first.subThoroughfare}');

   return first.addressLine!;
 }

  Future<String> _getRegion(double latitude, double longitude)async{
    final coordinates = Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    print('1. ${first.locality}, 2. ${first.adminArea}, 3. ${first.subLocality}, '
        '4. ${first.subAdminArea}, 5. ${first.addressLine}, 6. ${first.featureName},'
        '7, ${first.thoroughfare}, 8. ${first.subThoroughfare}');

    return first.adminArea!;
  }


  Future<Prediction?> _searchPlace() async {
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
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.white))),
        components: [Component(Component.country,"DZ")]);

    return p!;
  }

  void onError(PlacesAutocompleteResponse response){
    homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<Map<String, double>> _predictionToPosition(Prediction p, ScaffoldState? currentState) async {

    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    return {'latitude': lat, 'longitude':lng};
  }

  Future<void> _showDepartDialog( BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: const Text('votre position'),
                      onTap: ()async{
                        Navigator.pop(context);
                        Map<String, double> position = await _getCurrentLocation();
                        latitude_dpr = position['latitude']!;
                        longitude_dpr = position['longitude']!;
                        depart_adr = await _getAdress(latitude_dpr, longitude_dpr);
                        region = await _getRegion(latitude_dpr, longitude_dpr);

                        setState((){
                          _setMarker("depart", latitude_dpr, longitude_dpr);
                          depart = true;
                        });
                        print("depart : ${latitude_dpr},${longitude_dpr} : ${depart_adr}");
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text('choisir un endroid'),
                    onTap: ()async{
                      Navigator.pop(context);
                      Prediction? p = await _searchPlace();
                      Map<String, double> position = await _predictionToPosition(p!, homeScaffoldKey.currentState);
                      latitude_dpr = position['latitude']!;
                      longitude_dpr = position['longitude']!;
                      depart_adr = await _getAdress(latitude_dpr, longitude_dpr);

                      setState((){
                        _setMarker("depart", latitude_dpr, longitude_dpr);
                        depart = true;
                      });
                      print("depart : ${latitude_dpr},${longitude_dpr} : ${depart_adr}");
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showArriveDialog( BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: const Text('votre position'),
                      onTap: ()async{
                        Navigator.pop(context);
                        Map<String, double> position = await _getCurrentLocation();
                        latitude_arv = position['latitude']!;
                        longitude_arv =  position['longitude']!;
                        arrive_adr = await _getAdress(latitude_arv, longitude_arv);

                        setState((){
                          _setMarker("arrive", latitude_arv, longitude_arv);
                          arrive = true;
                        });
                        print("arrive : ${latitude_arv},${longitude_arv} : ${arrive_adr}");
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text('choisir un endroid'),
                    onTap: ()async{
                      Navigator.pop(context);
                      Prediction? p = await _searchPlace();
                      Map<String, double> position = await _predictionToPosition(p!, homeScaffoldKey.currentState);
                      latitude_arv = position['latitude']!;
                      longitude_arv =  position['longitude']!;
                      arrive_adr = await _getAdress(latitude_arv, longitude_arv);
                      setState((){
                        _setMarker("arrive", latitude_arv, longitude_arv);
                        arrive = true;
                      });
                      print("arrive : ${latitude_arv},${longitude_arv} : ${arrive_adr}");
                    },
                  )
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,

      body: Stack(
        children: [

          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            zoomControlsEnabled: false,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
      Positioned(
        bottom: 0.0,
        left: 0.0,
          child: Container(
              color: Colors.white,
              width: 360,
              height: 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff2E9FB0),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding:EdgeInsets.fromLTRB(5,10,0,10),
                          child: Icon(Icons.pin_drop_outlined, color: Colors.grey,),
                        ),
                        Expanded(
                                child:Container(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.all(11),
                                        child: GestureDetector(
                                          onTap: (){
                                            _showDepartDialog(context);
                                          },
                                            child: Text(this.depart? this.depart_adr : "point de départ", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)))))),

                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff2E9FB0),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(5,10,0,10),
                          child: const Icon(Icons.pin_drop_outlined, color: Colors.grey,),
                        ),
                        Expanded(
                          child: Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                child: Text(arrive? arrive_adr : "point d'arrivé", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                onTap: (){
                                  _showArriveDialog(context);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 300,

                    child: ElevatedButton(
                        onPressed: ()async{
                          //TODO  regler les attributs a passer entre les pages
                          if(depart && arrive ){
                            if(depart_adr != arrive_adr){
                              carLocation _carLocation = carLocation();
                              _carLocation.region = region;
                              _carLocation.latitude_depart = latitude_dpr;
                              _carLocation.longitude_depart = longitude_dpr;
                              _carLocation.point_depart = depart_adr;
                              _carLocation.latitude_arrive = latitude_arv;
                              _carLocation.longitude_arrive = longitude_arv;
                              _carLocation.point_arrive = arrive_adr;
                              await UserCredentials.refresh();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CarsList()),
                              );
                            }else{
                              homeScaffoldKey.currentState!.showSnackBar(const SnackBar(content: const Text('veuillez choisir des addresses différentes')));
                            }
                          }else if(!depart){
                            homeScaffoldKey.currentState!.showSnackBar(const SnackBar(content: const Text('veuillez choisir un point de départ')));
                          }else{
                            homeScaffoldKey.currentState!.showSnackBar(const SnackBar(content: Text('veuillez choisir un point d`arrivé')));
                          }

                        },
                        child:const Text("continuer"),
                        style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff2E9FB0)),

                        ),
                    ),
                  )
                ],
              )
          ),

      ),
        ],
      ),
    );
  }


}
