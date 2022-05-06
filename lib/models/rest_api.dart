import 'dart:convert';
import 'package:autotec/models/baridimob_payment.dart';
import 'package:http/http.dart' as http;
import 'user_data.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Api {
  static const _url = "https://autotek-server.herokuapp.com/";
  static var uri = Uri(host: "https://autotek-server.herokuapp.com/");

  static String formattedDateNow() {
    var now = DateTime.now();
    var formatter = DateFormat.yMd();
    String formattedDate = formatter.format(now);
    return formattedDate; // 2016-01-25
  }

//use this function to create a user
  static Future<http.Response> createUser(UserData u, String? token) async {
    return http.post(
      Uri.http('autotek-server.herokuapp.com',
          '/authentification_mobile/locataire_inscription/'),
      body: jsonEncode(<String, String>{
        "token": token!,
        "id": u.id!,
        "nom": u.nom!,
        "prenom": u.prenom!,
        "email": u.email!,
        "mot_de_passe": u.motDePasse!,
        "numero_telephone": u.numeroTelephone!,
        "photo_identite_recto": "test",
        "photo_identite_verso": "test",
        "photo_selfie": "test",
        "statut_compte": "false",
        "statut": "en attente",
        "date_inscription": DateTime.now().toString()
      }),
    );
  }

/*
use these functions to see what to print in the page after the inscription
to tcheck if he's validated or not
 */
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

  static Future<http.Response> sendBaridiMobDetails(
      BaridiMobPayment b, String token) async {
    return await http.post(
      Uri.parse(
          'https://autotek-server.herokuapp.com/paiement/verifier_paiement/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "token": token,
        "id_sender": userCredentials.uid!,
        "id": userCredentials.uid!,
        "id_facture": "1",
        "type_paiement": "baridimob",
        "heure_paiement": b.heurPaiement!,
        "date_paiement": b.heurPaiement!,
        "montant": b.montant!.toString(),
        "codetransaction": b.codeTransaction!,
        "id_transaction": "002021540661",
      }),
    );
  }
}
