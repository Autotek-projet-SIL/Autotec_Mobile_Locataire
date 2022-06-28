// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autotec/models/user_data.dart';
import "package:autotec/models/rest_api.dart";

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createAccountInDB(UserData user) async {
    await UserCredentials.refresh();
    user.id = UserCredentials.uid;
    final response = await Api.createUser(user, UserCredentials.token!);
    if (response.statusCode != 200) {
      throw Exception('insciption failed');
    }
  }

  Future<void> saveTokenDevice() async {
    await UserCredentials.setDeviceToken();
    await FirebaseFirestore.instance
        .collection('DeviceToken')
        .doc(UserCredentials.uid)
        .set({
          'device_token': UserCredentials.token,
        })
        .then((value) => print("token added"))
        .catchError((error) => print("Failed to add token: $error"));
  }
}
