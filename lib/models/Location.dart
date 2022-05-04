import 'package:flutter/material.dart';

import '../car_rental/Cars.dart';

class carLocation{

  carLocation._privateConstructor();

  // the info related to the location
  int? id;
  DateTime? dateDebut;
  TimeOfDay? heureDebut;
  TimeOfDay? heureFin;

  bool? enCours; // si y a une location en cours ou non
  String? etat;// none,
               // en attente (suivi du vehicule avant deverrouillage),
               // deverrouillage
               // trajet (suivi du trajet)
              // payement
  String? region;
  String? numero_chassis;

  String? point_depart;
  double? latitude_depart;
  double? longitude_depart;

  String? point_arrive;
  double? latitude_arrive;
  double? longitude_arrive;

  Car? car;

  static final carLocation _instance = carLocation._privateConstructor();

  factory carLocation(){
    return _instance;
  }
}
