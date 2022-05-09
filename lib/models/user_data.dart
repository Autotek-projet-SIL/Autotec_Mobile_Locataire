import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserData {
  String? id; //put the id of firebase user
  String? token;
  String? nom;
  String? prenom;
  String? email;
  String? motDePasse;
  String? numeroTelephone;
  /*XFile? photo_identite_recto;
  XFile? photo_identite_verso;
  XFile? photo_selfie;
  var photoIdentiteRecto;
  var photoIdentiteVerso;
  var photoSelfie;*/
  String? photoIdentiteRecto;
  String? photoIdentiteVerso;
  String? photoSelfie;
  String? statutCompte;
  UserData.a();
  UserData.n(
   {
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.motDePasse,
    this.numeroTelephone,
    this.photoIdentiteRecto,
    this.photoIdentiteVerso,
    this.photoSelfie,
  });
  UserData.m(
   {
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.motDePasse,
    this.numeroTelephone,
  });

  UserData.json(
      this.id,
      this.nom,
      this.prenom,
      this.email,
      this.statutCompte,
      this.motDePasse,
      this.numeroTelephone,
      this.photoIdentiteRecto,
      this.photoIdentiteVerso,
      this.photoSelfie);

  Future<String> imagetoBase64(File imagefile) async {
    /* use this function to assign an image field, give it the file to the image

     */

    //File imagefile = File(path); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string =
        base64.encode(imagebytes); //convert bytes to base64 string
    return base64string;
  }

  /* use this function to get the user from the services
      to check if his profil was validated or not
   */

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData.json(
        json['id'],
        json['nom'],
        json['prenom'],
        json['email'],
        json['statut_compte'],
        json['mot_de_passe'],
        json['numero_telephone'],
        json['photo_identite_recto'],
        json['photo_identite_verso'],
        json['photo_selfie']);
  }
}

class userCredentials {
  userCredentials._privateConstructor();

  static final userCredentials _instance = userCredentials
      ._privateConstructor();
  static String? devicetoken;
  static String? uid;
  static String? token;
  static String? email;

  factory userCredentials(){
    return _instance;
  }

  static setDeviceToken() async {
    devicetoken = await FirebaseMessaging.instance.getToken();
  }

  static Future<void> refresh() async {
    try {
      token = (await FirebaseAuth.instance.currentUser!.getIdToken());
      uid = (await FirebaseAuth.instance.currentUser?.uid);
      email = (await FirebaseAuth.instance.currentUser?.email);
    } on FirebaseAuthException catch (e) {
      print('auth exception!\n');
    }
  }
}