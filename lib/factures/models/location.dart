// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    required this.statusDemandeLocation,
    required this.idLocataire,
    required this.numeroChassis,
    required this.idLouer,
    required this.enCours,
    required this.heureDebut,
    required this.heureFin,
    required this.region,
    required this.dateDebut,
    required this.latitudeDepart,
    required this.longitudeDepart,
    required this.latitudeArrive,
    required this.longitudeArrive,
    required this.idFacture,
    required this.dateFacture,
    required this.montant,
    required this.heure,
    required this.tva,
    required this.marque,
    required this.modele,
    required this.couleur,
    required this.idTypeVehicule,
    required this.idAm,
    required this.imageVehicule,
    required this.libelle,
    required this.tarification,
  });

  String statusDemandeLocation;
  String idLocataire;
  String numeroChassis;
  int idLouer;
  bool enCours;
  String heureDebut;
  String heureFin;
  String region;
  DateTime dateDebut;
  int latitudeDepart;
  int longitudeDepart;
  int latitudeArrive;
  int longitudeArrive;
  int idFacture;
  DateTime dateFacture;
  int montant;
  String heure;
  int tva;
  String marque;
  String modele;
  String couleur;
  int idTypeVehicule;
  String idAm;
  String imageVehicule;
  String libelle;
  int tarification;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    statusDemandeLocation: json["status_demande_location"],
    idLocataire: json["id_locataire"],
    numeroChassis: json["numero_chassis"],
    idLouer: json["id_louer"],
    enCours: json["en_cours"],
    heureDebut: json["heure_debut"],
    heureFin: json["heure_fin"],
    region: json["region"],
    dateDebut: DateTime.parse(json["date_debut"]),
    latitudeDepart: json["latitude_depart"],
    longitudeDepart: json["longitude_depart"],
    latitudeArrive: json["latitude_arrive"],
    longitudeArrive: json["longitude_arrive"],
    idFacture: json["id_facture"],
    dateFacture: DateTime.parse(json["date_facture"]),
    montant: json["montant"],
    heure: json["heure"],
    tva: json["tva"],
    marque: json["marque"],
    modele: json["modele"],
    couleur: json["couleur"],
    idTypeVehicule: json["id_type_vehicule"],
    idAm: json["id_am"],
    imageVehicule: json["image_vehicule"],
    libelle: json["libelle"],
    tarification: json["tarification"],
  );

  Map<String, dynamic> toJson() => {
    "status_demande_location": statusDemandeLocation,
    "id_locataire": idLocataire,
    "numero_chassis": numeroChassis,
    "id_louer": idLouer,
    "en_cours": enCours,
    "heure_debut": heureDebut,
    "heure_fin": heureFin,
    "region": region,
    "date_debut": dateDebut.toIso8601String(),
    "latitude_depart": latitudeDepart,
    "longitude_depart": longitudeDepart,
    "latitude_arrive": latitudeArrive,
    "longitude_arrive": longitudeArrive,
    "id_facture": idFacture,
    "date_facture": dateFacture.toIso8601String(),
    "montant": montant,
    "heure": heure,
    "tva": tva,
    "marque": marque,
    "modele": modele,
    "couleur": couleur,
    "id_type_vehicule": idTypeVehicule,
    "id_am": idAm,
    "image_vehicule": imageVehicule,
    "libelle": libelle,
    "tarification": tarification,
  };
}
