// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Deverouillage extends StatefulWidget {
  const Deverouillage({Key? key}) : super(key: key);

  @override
  _DeverouillageState createState() => _DeverouillageState();
}

class _DeverouillageState extends State<Deverouillage> {

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all( Radius.circular(20.0))),
      contentPadding: const EdgeInsets.all(20.0),
      content: Container(child: const Text("Votre voiture est arrivée",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
      actions: <Widget>[
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.7,

            child: RaisedButton(
              color: const Color.fromRGBO(27, 146, 164, 0.7),
              hoverColor: Colors.black,
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),

              child: const Text(
                'Deverouiller',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: (){},
            ),

          ),
        )
      ],
    );





  }
}

class EnCours extends StatefulWidget {
  const EnCours({Key? key}) : super(key: key);

  @override
  State<EnCours> createState() => _EnCoursState();
}

class _EnCoursState extends State<EnCours> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      contentPadding: const EdgeInsets.all(20.0),
      content: SizedBox(height: 120,child: Column(
        children: const [
          SpinKitThreeBounce(color: Color.fromRGBO(27, 146, 164, 0.7)),
          SizedBox(height: 5),
          Text('traitement de la demande',style: TextStyle(fontSize: 15)),
          SizedBox(height: 5),
          Text('Veuillez patienter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
        ],
      )),

    );
  }
}