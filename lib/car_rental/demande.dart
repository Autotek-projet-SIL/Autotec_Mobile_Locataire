import 'package:autotec/models/Location.dart';
import 'package:autotec/models/user_data.dart';
import 'Cars.dart';
import '../components/WraisedButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CarsList.dart';
import 'package:http/http.dart';
import 'dart:convert';




class Demande extends StatefulWidget {

  const Demande( {
    Key? key
  }): super(key: key);

  @override
  State<Demande> createState() => _DemandeState();
}

class _DemandeState extends State<Demande> {

  carLocation _location = carLocation();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height*0.1),
            Image.asset(
              'assets/logo.png',
              width: 350,
            ),
            SizedBox(height: size.height * 0.05),
            Text('Louer une voiture',
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(_location.point_depart!,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),

                  ),
                ),
              ),
            ),

            SizedBox(height: 40),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(20.0),
                      child: Text(_location.point_arrive!,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),

                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(_location.car!.modele!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 20),
            WidgetRaisedButton(text: 'valider',
                press:()async{
              await userCredentials.refresh();
              print("token\n");
              print(userCredentials.token);
              print('uid\n');
              print (userCredentials.uid);
              //TODO post method with the location info
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ),
              );*/
            }, color: Color(0xff2E9FB0), textColor: Colors.white)


          ],
        ),
      ),
    );
  }

}
