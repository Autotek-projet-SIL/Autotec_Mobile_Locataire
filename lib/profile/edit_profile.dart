import 'dart:convert';

import 'package:autotec/components/WBack.dart';
import 'package:autotec/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../bloc/auth_bloc.dart';

import 'package:autotec/car_rental/home_page.dart';
import 'package:autotec/models/user_data.dart';

import '../components/WraisedButton.dart';
import '../components/WtextField.dart';
import '../components/WtextFieldDigit.dart';
import '../components/text_field.dart';

class EditProfile extends StatefulWidget {
  final String image;
  final String nom;
  final String prenom;
  final String numTlph;
  final String mdp;
  final String recto_photo;
  final String verso_photo;
  const EditProfile({Key? key,
  required this.image,
    required this.nom,
    required this.prenom,
    required this.numTlph,
    required this.mdp,
    required this.recto_photo,
    required this.verso_photo,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  void UpdateUser(String nom,String prenom,String num) async{
    var res=await http.put(
      Uri.parse('http://autotek-server.herokuapp.com/gestionprofils/modifier_locataire/${userCredentials.uid}'),
      body: {
        "token": "${userCredentials.token}",
        "id_sender": "${userCredentials.uid}",
        "nom": "$nom",
        "prenom": "$prenom",
        "email": "${userCredentials.email}",
        "mot_de_passe": "${widget.mdp}",
        "numero_telephone": "$num",
        "photo_identite_recto": "test",
        "photo_identite_verso": "test",
        "photo_selfie": "${widget.image}"

      },
    );
    if(res.statusCode==200){

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            Profile()
        ),
      );

    }else{
      print('errorrrrr');
    }

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
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
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
    TextEditingController nomController=TextEditingController(text: widget.nom);
    TextEditingController prenomController=TextEditingController(text: widget.prenom);
    TextEditingController numController=TextEditingController(text: widget.numTlph);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WidgetArrowBack()
                  ],
                ),
                SizedBox(height: size.height*0.02,),
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
                      NetworkImage(widget.image),

                      child: Icon(Icons.edit,size: 40,),
                    )
                ),

                SizedBox(height: size.height*0.02,),
                labelContainer("Nom :"),
                CustomTextField(controler: nomController,),
                SizedBox(height: size.height*0.015,),
                labelContainer("Prénom :"),
                CustomTextField(controler: prenomController,),
                SizedBox(height: size.height*0.015,),
                labelContainer("Numero de téléphone :"),
                CustomTextField(
                  onChanged: (value){
                    numController.text=value;
                  },
                  hintText: " Votre NUM",
                  controler: numController,
                  validationMode:
                  AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value != null
                        ? 'Enter a  valid email'
                        : null;
                  },
                ),
                SizedBox(height: size.height*0.03,),
                WidgetRaisedButton(press: () {
                  //print(widget.image);
                 // print(widget.mdp);
                 // print(numController.text);
                 UpdateUser(nomController.text,prenomController.text,numController.text);

                }, text: 'Modifier',color: Color(0xff2E9FB0),textColor: Colors.white,),


                /*RaisedButton(
                  child: Text('click me'),
                  onPressed: (){
                    print ("token : ${userCredentials.token}");
                    print("id : ${userCredentials.uid}");
                  },
                )*/
              ],
            )
        ),
      ),
    );
  }
}
