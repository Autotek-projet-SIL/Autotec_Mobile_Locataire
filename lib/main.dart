import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'car_rental/presentation/real_time_tracking.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'autotec',
      home:  MyMap(
        carId: "user1", 
        userId: "userId", // we use it to get thecar's location from firebase
        destinationLocation: LatLng(36.712813, 3.172565), // client location it's fixed at first
      ),
    );
  }
}


