// ignore_for_file: file_names

import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  String numeroChasis;
  String marque;
  String modele;
  String couleur;
  String idAm;
  String nom;
  String prenom;
  String email;
  String numeroTelephone;
  int idTypeVehicule;
  String? libelle;
  int tarification;
  String? type;
  String? image;
  String? color;

  Car({
    required this.numeroChasis,
    required this.marque,
    required this.modele,
    required this.couleur,
    required this.image,
    required this.idAm,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.numeroTelephone,
    required this.idTypeVehicule,
    required this.libelle,
    required this.tarification,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        numeroChasis: json["numero_chassis"],
        marque: json["marque"],
        modele: json["modele"],
        couleur: json["couleur"],
        image: json["image_vehicule"],
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
        "numero_chassis": numeroChasis,
        "marque": marque,
        "modele": modele,
        "couleur": couleur,
        "image_vehicule": image,
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
