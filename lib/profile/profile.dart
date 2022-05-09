import 'dart:convert';

import 'package:autotec/car_rental/Car_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../bloc/auth_bloc.dart';

import 'package:autotec/car_rental/home_page.dart';
import 'package:autotec/models/user_data.dart';

import '../factures/locationList.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String name;late String prenom;late String image;late String numero;late String mdp;
  late String nom;
  late String recto ;late String verso;
  bool circular =true;
  late var userProfile;

  @override
  void initState(){
    super.initState();
    getUser();
  }

    void getUser() async{
    var res=await http.get(
        Uri.https('autotek-server.herokuapp.com','authentification_mobile/locataire_connexion/${userCredentials.email}'),
        headers: <String, String>{
          "token": "${userCredentials.token}",
          "id_sender": "${userCredentials.uid}"
          ,
        },
        );
      setState(() {
        userProfile=json.decode(res.body);
        circular=false;
      });

  }



  Widget profileContainer(String text){
    Size size = MediaQuery.of(context).size;
    return  Container(
      margin: const EdgeInsets.only(top:5.0,left: 10.0, right: 10.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      height: 43,
      width: size.width*0.4,
      decoration: BoxDecoration(
        border: Border.all(
          color:Color(0xff2E9FB0),
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Text(text,textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
  Widget labelContainer(String text){
    Size size = MediaQuery.of(context).size;
    return Row (
      children: [
        SizedBox(width: size.width*0.05,),
        Text(text,style: TextStyle(color: Color(0xff696969).withOpacity(0.7),)),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: circular?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: () {
                    name="${userProfile[0]["nom"]}";
                    prenom="${userProfile[0]["prenom"]}";
                    numero="${userProfile[0]["numero_telephone"]}";
                    image="${userProfile[0]["photo_selfie"]}";
                    mdp="${userProfile[0]["mot_de_passe"]}";
                    recto="${userProfile[0]["photo_identite_recto"]}";
                    verso="${userProfile[0]["photo_identite_verso"]}";

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          EditProfile(image: image, nom: name, prenom: prenom, numTlph: numero, mdp: mdp, recto_photo: recto, verso_photo: verso)
                      ),
                    );
                  }, icon: Icon(Icons.edit ,size: 30,), hoverColor: Color(0xff2E9FB0),),

                ],
              ),
             /* RaisedButton(onPressed: (){
                //print(" token : ${userCredentials.token}");
                //print(" id : ${userCredentials.uid}");
               print("${userProfile[0]}");
              },
              child: Text("click me"),)*/
              //SizedBox(height: size.height*0.0001,),
              CircleAvatar(
                  radius: 85,
                  backgroundColor: Color(0xff2E9FB0),
                  child: CircleAvatar(
                    backgroundColor:Colors.transparent ,
                    radius: 80,
                    backgroundImage:
                    NetworkImage("${userProfile[0]["photo_selfie"]}"),
                  )
              ),

              SizedBox(height: size.height*0.02,),
              labelContainer("Nom :"),
              profileContainer("${userProfile[0]["nom"]}"),
              SizedBox(height: size.height*0.015,),
              labelContainer("Prénom :"),
              profileContainer("${userProfile[0]["prenom"]}"),
              SizedBox(height: size.height*0.015,),
              labelContainer("Adresse mail :"),
              profileContainer("${userProfile[0]["email"]}"),
              SizedBox(height: size.height*0.015,),
              labelContainer("Numero de téléphone :"),
              profileContainer("${userProfile[0]["numero_telephone"]}"),

              SizedBox(height: size.height*0.03,),

          GestureDetector(
            onTap: (){
              nom="${userProfile[0]["nom"]} ${userProfile[0]["prenom"]}";
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationList(nomLocataire: nom,)),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top:10.0,left: 10.0, right: 10.0),
              padding: const EdgeInsets.only(left: 15.0, right: 8.0),
              height: 50,
              width: size.width*0.4,
              decoration: BoxDecoration(
                color: Color(0xff2E9FB0),

                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,bottom: 4,top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(

                      children: [
                       // IconButton(onPressed: (){}, icon: Image.asset("assets/bill.png",width: 50,)),
                        Text("Mes Factures",textAlign: TextAlign.center,
                          style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color: Colors.white),
                        ),
                      ],
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: Colors.white,))
                  ],
                ),
              ),
            ),
          ),
              GestureDetector(
                onTap: (){
                  context.read<AuthBloc>().add(SignOutRequested());
                },
                child: Container(
                  margin: const EdgeInsets.only(top:10.0,left: 10.0, right: 10.0),
                  padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                  height: 50,
                  width: size.width*0.4,
                  decoration: BoxDecoration(
                    color: Color(0xff2E9FB0),

                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 4,top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                           // IconButton(onPressed: (){}, icon: Image.asset("assets/hello.png",width: 50,)),
                            Text("Deconnexion",textAlign: TextAlign.center,
                              style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color: Colors.white),
                            ),
                          ],
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.exit_to_app,color: Colors.white,))
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(
                child: Text('click me'),
                onPressed: (){
                  print ("token : ${userCredentials.token}");
                 // print("id : ${userCredentials.uid}");

                },
              )
            ],
          )
        ),
      ),
    );
  }
}
