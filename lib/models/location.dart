// ignore_for_file: non_constant_identifier_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../car_rental/Cars.dart';

class CarLocation {
  CarLocation._privateConstructor();

  // the info related to the location
  int? id_location;
  int? id_paiement;
  DateTime? dateDebut;
  TimeOfDay? heureDebut;
  TimeOfDay? heureFin;

  int? montant;

  bool? enCours; // si y a une location en cours ou non
  String? etat; // none,
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

  static final CarLocation _instance = CarLocation._privateConstructor();

  factory CarLocation() {
    return _instance;
  }
  CarLocation.a({id_location})
  {
    this.id_location = id_location;
  }
  factory CarLocation.fromJson(Map<String, dynamic> json) => CarLocation.a(
      id_location : json["id_louer"]
  );
}

