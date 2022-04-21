
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_data.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Api {
  static const _url =
        "https://autotek-server.herokuapp.com/";
  static var uri = Uri(host:"https://autotek-server.herokuapp.com/");

  static String formattedDateNow() {
    var now = DateTime.now();
    var formatter = DateFormat.yMd();
    String formattedDate = formatter.format(now);
    return formattedDate; // 2016-01-25
  }

//use this function to create a user
  static Future<http.Response> createUser(UserData u, String? token) async {
    return http.post(
      Uri.http('autotek-server.herokuapp.com','/authentification_mobile/locataire_inscription/'),

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
    final response = await http
        .get(Uri.parse(''));

    if (response.statusCode == 200) {
      UserData u = UserData.fromJson(jsonDecode(response.body));
      if (u.statutCompte != null) {
        return u.statutCompte;
      }
      return false;
    }
    return false;
  }
}
