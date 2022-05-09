// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  Car({
    required this.numeroChassis,
    required this.marque,
    required this.modele,
    required this.couleur,
    required this.imageVehicule,
    required this.idAm,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.numeroTelephone,
    required this.idTypeVehicule,
    required this.libelle,
    required this.tarification,
  });

  String numeroChassis;
  String marque;
  String modele;
  String couleur;
  String imageVehicule;
  String idAm;
  String nom;
  String prenom;
  String email;
  String numeroTelephone;
  int idTypeVehicule;
  String libelle;
  int tarification;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    numeroChassis: json["numero_chassis"],
    marque: json["marque"],
    modele: json["modele"],
    couleur: json["couleur"],
    imageVehicule: json["image_vehicule"],
    idAm: json["id_am"],
    nom: json["nom"],
    prenom: json["prenom"],
    email: json["email"],
    numeroTelephone: json["numero_telephone"],
    idTypeVehicule: json["id_type_vehicule"],
    libelle: json["libelle"],
    tarification: json["tarification"],
  );

  Map<String, dynamic> toJson() => {
    "numero_chassis": numeroChassis,
    "marque": marque,
    "modele": modele,
    "couleur": couleur,
    "image_vehicule": imageVehicule,
    "id_am": idAm,
    "nom": nom,
    "prenom": prenom,
    "email": email,
    "numero_telephone": numeroTelephone,
    "id_type_vehicule": idTypeVehicule,
    "libelle": libelle,
    "tarification": tarification,
  };
}
