import 'dart:convert';

import 'package:autotec/components/WviewTrip.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/WBack.dart';
import '/components/WviewCar.dart';
import 'package:autotec/models/user_data.dart';

import 'factureDetails.dart';
import 'models/location.dart';

class LocationList extends StatefulWidget {
  final String nomLocataire;
  const LocationList({Key? key, required this.nomLocataire}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  late String nom;
  late String numeroChassis;
  late String heureDebut;
  late String heureFin;
  late String region;
  late DateTime dateDebut;
  late int idFacture;
//  DateTime dateFacture;
  late int montant;
  // String heure;
  late String pointDepart;
  late String pointArrive;
  late String marque;
  late String modele;

  Future<List<Location>> _getLocations() async{
    var Url = Uri.https("autotek-server.herokuapp.com","/gestionlocations/get_locations_termines_by_locataire/${userCredentials.uid!}");
    // print (Url.toString());
    final response = await http.get(Url, headers: {'token':userCredentials.token!,'id_sender':userCredentials.uid!});
    List<Location> locations=[];

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body) ;
     /* for(var l in jsonData){
        Location location =Location(statusDemandeLocation: l["status_demande_location"], idLocataire: l["id_locataire"], numeroChassis: l["numero_chassis"], idTrajet: l["id_trajet"], idLouer: l["id_louer"], enCours: l["en_cours"], heureDebut: l["heure_debut"], heureFin: l["heure_fin"], region: l["region"], dateDebut: DateTime.parse(l["date_debut"]));
        //Location location =Location(statusDemandeLocation: l["status_demande_location"], idLocataire: l["id_locataire"], numeroChassis: l["numero_chassis"], idTrajet: l["id_trajet"], idLouer: l["id_louer"], enCours: l["en_cours"], heureDebut: l["heure_debut"], heureFin: l["heure_fin"], region: l["region"], dateDebut: DateTime.parse(l["date_debut"]));
        locations.add(location);
        }*/
      print(jsonData);
      return jsonData.map((json) => new Location.fromJson(json)).toList();

    } else if (response.statusCode == 403) {
      throw Exception('access forbiden');
    }else{

      throw Exception('Failed to load locations from API');
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.04,
            ),
            Row(
              children: [
                WidgetArrowBack(),
                SizedBox(width: 12,),
                Text(
                  'Historique des factures',
                  style: TextStyle(
                    fontFamily: 'poppin',
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: size.height*0.7,
                child: FutureBuilder<List<Location>>(
                  future: _getLocations(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Location>? data = snapshot.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: (){
                                  numeroChassis="${data![index].numeroChassis}";
                                  heureDebut=data![index].heureDebut;
                                  heureFin=data![index].heureFin;
                                  region="${data![index].region}";
                                  dateDebut=data![index].dateDebut;
                                  idFacture=data![index].idFacture;
                                  montant =data![index].montant;
                                  marque=data![index].marque;
                                  modele=data![index].modele;
                                  nom=widget.nomLocataire;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                   FactureDetails(nomLoc:nom,numeroChassis: numeroChassis, heureDebut: heureDebut, heureFin: heureFin, region: region, dateDebut: dateDebut, idFacture: idFacture, montant: montant, marque: marque, modele: modele)
                                    ),
                                  );
                                },
                                child: WidgetViewTrip(carName: "${data![index].modele}", carPrice: "${data![index].montant} DA", start: "${data![index].dateDebut.day}-${data![index].dateDebut.month}-${data![index].dateDebut.year} à ${data![index].heureDebut}", end: "${data![index].dateDebut.day}-${data![index].dateDebut.month}-${data![index].dateDebut.year} à ${data![index].heureFin}", press: () {
                                  numeroChassis="${data![index].numeroChassis}";
                                  heureDebut=data![index].heureDebut;
                                  heureFin=data![index].heureFin;
                                  region="${data![index].region}";
                                  dateDebut=data![index].dateDebut;
                                  idFacture=data![index].idFacture;
                                  montant =data![index].montant;
                                  marque=data![index].marque;
                                  modele=data![index].modele;
                                  nom=widget.nomLocataire;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        FactureDetails(nomLoc:nom,numeroChassis: numeroChassis, heureDebut: heureDebut, heureFin: heureFin, region: region, dateDebut: dateDebut, idFacture: idFacture, montant: montant, marque: marque, modele: modele)
                                    ),
                                  );
                                },));
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}
