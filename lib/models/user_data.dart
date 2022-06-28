// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserData {
  String? id;
  String? token;
  String? nom;
  String? prenom;
  String? email;
  String? motDePasse;
  String? numeroTelephone;
  String? photoIdentiteRecto;
  String? photoIdentiteVerso;
  String? photoSelfie;
  String? statutCompte;
  UserData.a();
  UserData.n({
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
  UserData.m({
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
    Uint8List imagebytes = await imagefile.readAsBytes();
    String base64string = base64.encode(imagebytes);
    return base64string;
  }

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

class UserCredentials {
  UserCredentials._privateConstructor();
  static final UserCredentials _instance =
      UserCredentials._privateConstructor();
  static String? devicetoken;
  static String? uid;
  static String? token;

  factory UserCredentials() {
    return _instance;
  }
  static setDeviceToken() async {
    devicetoken = await FirebaseMessaging.instance.getToken();
  }

  static Future<void> refresh() async {
    try {
      token = (await FirebaseAuth.instance.currentUser!.getIdToken());
      uid = (FirebaseAuth.instance.currentUser?.uid);
    } on FirebaseAuthException catch (e) {
      print('auth exception!\n');
      print(e);
    }
  }
}
