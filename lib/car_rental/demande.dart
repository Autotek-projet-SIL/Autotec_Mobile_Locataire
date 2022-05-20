// ignore_for_file: avoid_unnecessary_containers, avoid_print, prefer_final_fields

import 'package:autotec/car_rental/sliding_up_panel.dart';
import 'package:autotec/models/location.dart';
import 'package:autotec/models/user_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../components/WraisedButton.dart';
import 'package:flutter/material.dart';

import '../models/rest_api.dart';

class Demande extends StatefulWidget {
  const Demande({Key? key}) : super(key: key);

  @override
  State<Demande> createState() => _DemandeState();
}

class _DemandeState extends State<Demande> {
  CarLocation _location = CarLocation();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            Image.asset(
              'assets/logo.png',
              width: 350,
            ),
            SizedBox(height: size.height * 0.05),
            const Text(
              'Louer une voiture',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(_location.point_depart!,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(_location.point_arrive!,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(_location.car!.modele,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 20),
            WidgetRaisedButton(
                text: 'valider',
                press: () async {
                  await UserCredentials.refresh();
                  print("token\n");
                  print(UserCredentials.token);
                  print('uid\n');
                  print(UserCredentials.uid);
                  //TODO post method with the location info
                  print("numero de chasis");
                  print(_location.car!.numeroChasis);
                  final response = await Api.postLocation("en attente", _location);
                  if (response.statusCode != 200){
                    print(response.statusCode);
                  }
                  else{
                    print("location added");
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackingScreen(
                        destinationLocation: LatLng(_location.latitude_depart!,
                            _location.longitude_depart!),
                        carid: _location.car!.numeroChasis,
                        location: _location,
                      ),
                    ),
                  );
                  print("latitude" + _location.latitude_depart!.toString());
                  print("longitude" + _location.longitude_arrive!.toString());
                },
                color: const Color(0xff2E9FB0),
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
