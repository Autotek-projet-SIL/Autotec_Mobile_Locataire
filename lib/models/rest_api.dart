// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:autotec/factures/models/location.dart';
import 'package:autotec/models/location.dart' as prefix;
import 'package:http/http.dart' as http;
import 'location.dart';
import 'user_data.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Api {
  static const _url = "https://autotek-server.herokuapp.com/";
  static var uri = Uri(host: "https://autotek-server.herokuapp.com/");

  static String formattedDateNow() {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(now);
    return formattedDate; // 2016-01-25
  }

  static String formattedhourNow() {
    var now = DateTime.now();
    var formatter = DateFormat("HH:mm:ss");
    String formattedHour = formatter.format(now);
    return formattedHour; // 2016-01-25
  }

//use this function to create a user
  static Future<http.Response> createUser(UserData u, String token) async {
    return await http.post(
      Uri.parse(
          'https://autotek-server.herokuapp.com/authentification_mobile/locataire_inscription/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id_sender": u.id!,
        "id": u.id!,
        "token": token,
        "nom": u.nom!,
        "prenom": u.prenom!,
        "email": u.email!,
        "mot_de_passe": u.motDePasse!,
        "numero_telephone": u.numeroTelephone!,
        "photo_identite_recto": u.photoIdentiteRecto!,
        "photo_identite_verso": u.photoIdentiteVerso!,
        "photo_selfie": u.photoSelfie!,
        "statut_compte": "f",
        "statut": "en attente",
        "date_inscription": formattedDateNow()
      }),
    );}

  static Future<http.Response> getUser(String email) async {
    return http.get(
      Uri.parse(_url + email),
    );
  }

  static Future<Object?> isUserValidated(String email) async {
    final response = await http.get(Uri.parse(''));

    if (response.statusCode == 200) {
      UserData u = UserData.fromJson(jsonDecode(response.body));
      if (u.statutCompte != null) {
        return u.statutCompte;
      }
      return false;
    }
    return false;
  }


  static Future<int?> postLocation(String status, CarLocation _location) async {
    final response = await http.post(
      Uri.parse(
          'https://autotek-server.herokuapp.com/gestionlocations/ajouter_location/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
        'date_debut': formattedDateNow(),
        'status_demande_location': status,
        'id_locataire': UserCredentials.uid!,
        'region': _location.region!,
        'numero_chassis': _location.car!.numeroChasis, //TODO notice them that it can be null in case demande rejetee
        'en_cours': "t", // t or f
        'latitude_depart': _location.latitude_depart!.toString(),
        'longitude_depart': _location.longitude_depart!.toString(),
        'latitude_arrive': _location.latitude_arrive!.toString(),
        'longitude_arrive': _location.longitude_arrive!.toString()
      }),
    );
    if (response.statusCode == 200){
      CarLocation locationId = CarLocation.fromJson(jsonDecode(response.body)[0]) ;
      print(locationId.id);
      return locationId.id;
    }

  }

  static Future<http.Response> updateLocationState(String etat, int id_location) async {
    UserCredentials.refresh();
    final http.Response response = await http.put(
      Uri.parse('https://autotek-server.herokuapp.com/gestionlocations/update_suivi_location/$id_location'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        "suivi_location":etat,
        "token": UserCredentials.token!,
        "id_sender": UserCredentials.uid!,
      }),
    );
    if(response.statusCode == 200){
      print("status changed to {$etat}");
    }
    else{
      print(response.statusCode);
    }
    return response;
  }

  static Future<http.Response> getLocations() async {
    return http.get(
      Uri.parse(_url + "locations_encours"),
    );
  }

  static Future<http.Response> getLocationsEnCoursByID(String id) async {
    print("https://autotek-server.herokuapp.com/get_locations_by_locataire/$id");
    return http.get(
      Uri.parse(
          "https://autotek-server.herokuapp.com/get_locations_by_locataire/$id"),);
  }

  static Future<http.Response> sendBaridiMobDetails(String code, String token) async {
    return await http.post(
      Uri.parse(
          'https://autotek-server.herokuapp.com/paiement/verifier_paiement/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "token": token,
        "id_sender": UserCredentials.uid!,
        "id": UserCredentials.uid!,
        "id_facture": "1",
        "type_paiement": "baridimob",
        "heure_paiement": formattedhourNow(),
        "date_paiement": formattedDateNow(),
        "montant": "10000.0",
        "codetransaction": code,
        "id_transaction": "002021540661",
      }),
    );
  }

  static Future<http.Response> endLocation(
      String code, String token, String id) async {
    return await http.put(
      Uri.parse(
          'https://autotek-server.herokuapp.com/gestionlocations/end_location/' +
              id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "heure": formattedhourNow(),
      }),
    );
  }

}
