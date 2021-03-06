// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:autotec/components/WBack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../bloc/auth_bloc.dart';
import 'package:autotec/models/user_data.dart';
import '../car_rental/search_screen.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String name;
  late String prenom;
  late String image;
  late String numero;
  late String mdp;
  late String nom;
  late String recto;
  late String verso;
  bool circular = true;
  late var userProfile;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    UserCredentials.refresh();
    String? email = FirebaseAuth.instance.currentUser?.email;
    var res = await http.get(
      Uri.parse(
          "https://autotek-server.herokuapp.com/authentification_mobile/locataire_connexion/$email"),
      headers: <String, String>{
        "token": "${UserCredentials.token}",
        "id_sender": "${UserCredentials.uid}",
      },
    );
    setState(() {
      userProfile = json.decode(res.body);
      circular = false;
    });
  }

  Widget profileContainer(String text) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      height: 43,
      width: size.width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff2E9FB0),
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget labelContainer(String text) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.05,
        ),
        Text(text,
            style: TextStyle(
              color: const Color(0xff696969).withOpacity(0.7),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 5, 20, 5),
              child: IconButton(
                onPressed: () async {
                  await UserCredentials.refresh();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPlacesScreen()),
                  );
                },
                icon: const Icon(Icons.car_rental_outlined,
                    color: Colors.grey, size: 30),
                tooltip: 'rent a car',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 5, 50, 5),
              child: IconButton(
                onPressed: () async {
                  await UserCredentials.refresh();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
                icon: const Icon(Icons.person_outlined,
                    color: Color(0xff2E9FB0), size: 30),
                tooltip: 'open profil',
              ),
            ),
          ],
        ),
        notchMargin: 5,
      ),
      body: circular
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const WidgetArrowBack(),
                          IconButton(
                            onPressed: () {
                              name = "${userProfile[0]["nom"]}";
                              prenom = "${userProfile[0]["prenom"]}";
                              numero = "${userProfile[0]["numero_telephone"]}";
                              image = "${userProfile[0]["photo_selfie"]}";
                              mdp = "${userProfile[0]["mot_de_passe"]}";
                              recto =
                                  "${userProfile[0]["photo_identite_recto"]}";
                              verso =
                                  "${userProfile[0]["photo_identite_verso"]}";

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                        image: image,
                                        nom: name,
                                        prenom: prenom,
                                        numTlph: numero,
                                        mdp: mdp,
                                        recto_photo: recto,
                                        verso_photo: verso)),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 30,
                            ),
                            hoverColor: const Color(0xff2E9FB0),
                          ),
                        ],
                      ),
                      CircleAvatar(
                          radius: 85,
                          backgroundColor: const Color(0xff2E9FB0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 80,
                            backgroundImage: NetworkImage(
                                "${userProfile[0]["photo_selfie"]}"),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      labelContainer("Nom :"),
                      profileContainer("${userProfile[0]["nom"]}"),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      labelContainer("Pr??nom :"),
                      profileContainer("${userProfile[0]["prenom"]}"),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      labelContainer("Adresse mail :"),
                      profileContainer("${userProfile[0]["email"]}"),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      labelContainer("Numero de t??l??phone :"),
                      profileContainer("${userProfile[0]["numero_telephone"]}"),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          nom =
                              "${userProfile[0]["nom"]} ${userProfile[0]["prenom"]}";
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0),
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 8.0),
                          height: 50,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            color: const Color(0xff2E9FB0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 4, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Mes Factures",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(SignOutRequested());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0),
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 8.0),
                          height: 50,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            color: const Color(0xff2E9FB0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 4, top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Deconnexion",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.exit_to_app,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}
