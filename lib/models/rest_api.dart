// ignore_for_file: avoid_print

import 'dart:convert';
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
    return formattedDate;
  }

  static String formattedhoureNow() {
    var now = DateTime.now();
    var formatter = DateFormat("HH:mm:ss");
    String formattedHour = formatter.format(now);
    return formattedHour;
  }

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
        'en_cours': "t",
        'latitude_depart': _location.latitude_depart!.toString(),
        'longitude_depart': _location.longitude_depart!.toString(),
        'latitude_arrive': _location.latitude_arrive!.toString(),
        'longitude_arrive': _location.longitude_arrive!.toString()
      }),
    );
    if (response.statusCode == 200) {
      CarLocation locationId =
          CarLocation.fromJson(jsonDecode(response.body)[0]);
      print(locationId.id_location);
      return locationId.id_location;
    } else {
      return -1;
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
        'latitude_depart': 0.toString(),
        'longitude_depart': 0.toString(),
        'latitude_arrive': 0.toString(),
        'longitude_arrive': 0.toString()
      }),
    );
    if (response.statusCode == 200) {
      CarLocation locationId =
          CarLocation.fromJson(jsonDecode(response.body)[0]);
      print(locationId.id_location);
      return locationId.id_location;
    } else {
      return -1;
    }
  }

  static Future<http.Response> updateLocationState(
      String etat, int idLocation) async {
    UserCredentials.refresh();
    final http.Response response = await http.put(
      Uri.parse(
          'https://autotek-server.herokuapp.com/gestionlocations/update_suivi_location/$idLocation'),
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
    } else {
      print(response.statusCode);
    }
    return response;
  }

  static Future<http.Response> updateLocationHeureDebut(int idLocation) async {
    UserCredentials.refresh();
    final http.Response response = await http.put(
      Uri.parse(
          'https://autotek-server.herokuapp.com/gestionlocations/update_location_heure_debut/$idLocation'),
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
      return response;
    }
    return response;
  }

  static Future<int?> verifierPaiementStripe(
      String typePaiement,
      String montant,
      String typeCard,
      String numeroCard,
      String month,
      String year,
      String cvc) async {
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
        "type_paiement": typePaiement,
        "heure_paiement": formattedhoureNow(),
        "date_paiement": formattedDateNow(),
        "email": email.toString(),
        "montant": montant,
        "name": typeCard,
        "numero_card": numeroCard,
        "exp_month": month,
        "exp_year": year,
        "cvc": cvc
      }),
    );
    if (response.statusCode == 200) {
      PaymentId paymentId = PaymentId.fromJson(jsonDecode(response.body)[0]);
      print(paymentId.id_payment);
      return paymentId.id_payment;
    } else {
      return -1;
    }
  }

  static Future<int?> verifierPaiementBaridiMob(
      String typePaiement, String montant, String idTransaction) async {
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
        "type_paiement": typePaiement,
        "heure_paiement": formattedhoureNow(),
        "date_paiement": formattedDateNow(),
        "email": email.toString(),
        "id_transaction": idTransaction,
        "montant": montant
      }),
    );
    if (response.statusCode == 200) {
      PaymentId paymentId = PaymentId.fromJson(jsonDecode(response.body)[0]);
      return paymentId.id_payment;
    } else {
      return -1;
    }
  }

  static Future<http.Response> endLocation(CarLocation _location) async {
    String idLocation = _location.id_location.toString();
    print(idLocation);
    print(_location.id_paiement.toString());
    UserCredentials.refresh();
    final response = await http.put(
      Uri.parse(
          'https://autotek-server.herokuapp.com/gestionlocations/end_location/$idLocation'),
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
    if (response.statusCode == 200) {
      print("end location is working");
    } else {
      print(response.statusCode);
    }
    return response;
  }

  static Future<int?> getLocationById(int idLocation) async {
    final response = await http.get(
      Uri.parse(
          "https://autotek-server.herokuapp.com/getlocations/location/$idLocation"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
      },
    );
    if (response.statusCode == 200) {
      CarLocation location = CarLocation.fromJson(jsonDecode(response.body)[0]);
      return location.car?.tarification;
    } else {
      return null;
    }
  }

  static Future<http.Response> getLocationsEnCoursByID(int idLocataire) async {
    idLocataire = UserCredentials.uid as int;
    final response = await http.get(
      Uri.parse(
          "https://autotek-server.herokuapp.com/getlocations/get_locations_by_locataire/$idLocataire"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "id_sender": UserCredentials.uid!,
        "token": UserCredentials.token!,
      },
    );
    return response;
  }

  static Future<http.Response> sendBaridiMobDetails(
      String code, String token) async {
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

  static Future<http.Response> addDemandeSupport(
      String descriptif, String objet, String email, int idLouer) async {
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
        "id_louer": idLouer.toString(),
      }),
    );
    return response;
  }
}
