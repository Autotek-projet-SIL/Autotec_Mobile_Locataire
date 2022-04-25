
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
    var formatter = DateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(now);
    return formattedDate; // 2016-01-25
  }

//use this function to create a user
  static Future<http.Response> createUser(UserData u, String token) async {
    print("token "+ token.toString());
    print("nom: "+ u.nom!);
    print("prenom "+ u.prenom!);
    print("email "+ u.email!);
    print("date "+ formattedDateNow());


    return await http.post(
      Uri.parse('https://autotek-server.herokuapp.com/authentification_mobile/locataire_inscription/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        "id_sender": u.id!,
        "id":u.id!,
        "token":token,
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
