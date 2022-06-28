// ignore_for_file: non_constant_identifier_names, file_names



import '../car_rental/Cars.dart';

class CarLocation {
  CarLocation._privateConstructor();
  int? id_location;
  int? id_paiement;
  String? dateDebut;
  String? heureDebut;
  String? heureFin;
  int? montant;
  bool? enCours;
  String? etat;
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
  CarLocation.a({id_location, tarification}) {
    id_location = id_location;
    car?.tarification = tarification;
  }
  factory CarLocation.fromJson(Map<String, dynamic> json) => CarLocation.a(
      id_location: json["id_louer"], tarification: json["tarification"]);
}
