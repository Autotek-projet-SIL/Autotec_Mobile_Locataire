// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:autotec/models/location.dart' as prefix;
import 'package:autotec/payment/PaymentId.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  static String formattedhoureNow() {
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
    );
  }

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


  static Future<int?> postLocation(CarLocation _location) async {
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
        'status_demande_location': "accepte",
        'id_locataire': UserCredentials.uid!,
        'region': _location.region!,
        'numero_chassis': _location.car!.numeroChasis,
        //TODO notice them that it can be null in case demande rejetee
        'en_cours': "t",
        // t or f
        'latitude_depart': _location.latitude_depart!.toString(),
        'longitude_depart': _location.longitude_depart!.toString(),
        'latitude_arrive': _location.latitude_arrive!.toString(),
        'longitude_arrive': _location.longitude_arrive!.toString()
      }),
    );
    if (response.statusCode == 200) {
      CarLocation locationId = CarLocation.fromJson(
          jsonDecode(response.body)[0]);
      print(locationId.id_location);
      return locationId.id_location;
    }
  }
  static Future<int?> postLocationRejected() async {
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
        'status_demande_location': "rejete",
        'id_locataire': UserCredentials.uid!,
        'region': "",
        'numero_chassis': "",
        'en_cours': "f",
        // t or f
        'latitude_depart': "",
        'longitude_depart': "",
        'latitude_arrive': "",
        'longitude_arrive': ""
      }),
    );
    if (response.statusCode == 200) {
      CarLocation locationId = CarLocation.fromJson(
          jsonDecode(response.body)[0]);
      print(locationId.id_location);
      return locationId.id_location;
    }
  }

  static Future<http.Response> updateLocationState(String etat, int id_location) async {
    UserCredentials.refresh();
    final http.Response response = await http.put(
      Uri.parse(
          'https://autotek-server.herokuapp.com/gestionlocations/update_suivi_location/$id_location'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "suivi_location": etat,
        "token": UserCredentials.token!,
        "id_sender": UserCredentials.uid!,
      }),
    );
    if (response.statusCode == 200) {
      print("status changed to {$etat}");
    }
    else {
      print(response.statusCode);
    }
    return response;
  }

  static Future<http.Response> updateLocationHeureDebut(int id_location) async {
    UserCredentials.refresh();
    final http.Response response = await http.put(
      Uri.parse(
          'https://autotek-server.herokuapp.com/gestionlocations/update_location_heure_debut/$id_location'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "heure": formattedhoureNow(),
        "token": UserCredentials.token!,
        "id_sender": UserCredentials.uid!,
      }),
    );
    if (response.statusCode == 200) {
      print("heure debut fixed");
    }
    else {
      print(response.statusCode);
    }
    return response;
  }

  static Future<int?> verifierPaiementStripe(String type_paiement,
      String montant, String type_card, String numero_card, String month,
      String year, String cvc) async {
    UserCredentials.refresh();
    String? email = FirebaseAuth.instance.currentUser?.email;
    final response = await http.post(
      Uri.parse(
          'https://autotek-server.herokuapp.com/paiement/verifier_paiement/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
        "id": UserCredentials.uid!,
        "type_paiement": type_paiement,
        "heure_paiement": formattedhoureNow(),
        "date_paiement": formattedDateNow(),
        "email": email.toString(),
        "montant": montant,
        "name": type_card,
        "numero_card": numero_card,
        "exp_month": month,
        "exp_year": year,
        "cvc": cvc
      }),
    );
    if (response.statusCode == 200) {
      PaymentId paymentId = PaymentId.fromJson(
          jsonDecode(response.body)[0]);
      print(paymentId.id_payment);
      return paymentId.id_payment;
    }
    else {
      print(response.statusCode);
    }
  }
  static Future<int?> verifierPaiementBaridiMob(String type_paiement,
      String montant, String id_transaction) async {
    UserCredentials.refresh();
    String? email = FirebaseAuth.instance.currentUser?.email;
    final response = await http.post(
      Uri.parse(
          'https://autotek-server.herokuapp.com/paiement/verifier_paiement/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
        "id": UserCredentials.uid!,
        "type_paiement": type_paiement,
        "heure_paiement": formattedhoureNow(),
        "date_paiement": formattedDateNow(),
        "email": email.toString(),
        "id_transaction": id_transaction,
        "montant": montant
      }),
    );
    if (response.statusCode == 200) {
      PaymentId paymentId = PaymentId.fromJson(
          jsonDecode(response.body)[0]);
      print(paymentId.id_payment);
      return paymentId.id_payment;
    }
    else {
      print(response.statusCode);
    }
  }
  static Future<http.Response> endLocation(CarLocation _location) async {
    String id_location = _location.id_location.toString();
    print(id_location);
    print(_location.id_paiement.toString());
    UserCredentials.refresh();
    final response = await http.put(
      Uri.parse(
          'https://autotek-server.herokuapp.com/gestionlocations/end_location/$id_location'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
        "heure": formattedhoureNow(),
        "numero_chassis": _location.car!.numeroChasis,
        "date_facture": formattedDateNow(),
        "montant": _location.montant.toString(),
        "tva": 17.toString(),
        "id_louer": _location.id_location.toString(),
        "id_payer": _location.id_paiement.toString()
      }),
    );
    if(response.statusCode == 200){
      print("end location is working");
    }else{
      print(response.statusCode);
    }
    return response;
  }
  static Future<int?> getLocationById(int id_location) async {
    final response = await http.get(
      Uri.parse(
          "https://autotek-server.herokuapp.com/getlocations/location/$id_location"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
      },
    );
    if (response.statusCode == 200) {
      CarLocation location = CarLocation.fromJson(
          jsonDecode(response.body)[0]);
      print(location.car?.tarification);
      return location.car?.tarification ;
    }
  }

  static Future<http.Response> getLocationsEnCoursByID(int id_locataire) async {
    id_locataire = UserCredentials.uid as int;
    final response = await http.get(
      Uri.parse(
          "https://autotek-server.herokuapp.com/getlocations/get_locations_by_locataire/$id_locataire"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
      },
    );
    return response;
  }

  static Future<http.Response> sendBaridiMobDetails(String code,
      String token) async {
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
        "heure_paiement": formattedhoureNow(),
        "date_paiement": formattedDateNow(),
        "montant": "10000.0",
        "codetransaction": code,
        "id_transaction": "002021540661",
      }),
    );
  }

  static Future<http.Response> getUserPassword() async {
    String? email = FirebaseAuth.instance.currentUser?.email;
    print(email.toString());
    final response = await http.get(
      Uri.parse(
          "https://autotek-server.herokuapp.com/authentification_mobile/locataire_connexion/$email"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
      },
    );
    print(response.statusCode);
    return response;
  }

  static Future<http.Response> addDemandeSupport(String descriptif, String objet, String email, int id_louer) async {
    final response = await http.post(
      Uri.parse(
          'https://autotek-server.herokuapp.com/demande_support/ajouter_demande_support/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
        "objet": objet,
        "descriptif": descriptif,
        "email": email.toString(),
        "id_louer": id_louer.toString(),
      }),
    );
    return response;
  }


}
