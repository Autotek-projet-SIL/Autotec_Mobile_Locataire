
import 'package:flutter/material.dart';

import 'package:autotec/models/user_data.dart';
import 'package:autotec/car_rental/demande.dart';
import '../car_rental/Car_details.dart';
import '../car_rental/Cars.dart';


class WidgetViewCar extends StatelessWidget {
  final Car car;
  final String DateDebut;
  final String DateFin;
  final double latitude;
  final double longitude;
  const WidgetViewCar({
    Key? key,
    required this.car, required this.DateDebut, required this.DateFin, required this.latitude, required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: ()async{
            await userCredentials.refresh();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Demande(latitude: this.latitude, longitude: this.longitude, dateDebut:this.DateDebut,dateFin: this.DateFin, car: this.car)),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top:10.0),
            height: 140,
            decoration: const BoxDecoration(

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
            ),
            child: Stack(
              children:  [
                Positioned(
                  top:10.0,
                  left: 10.0,
                  child: Image.network(car.image,width: 120),
                ),
                Positioned(
                  top:25.0,
                 left: 145,
                  child:Column(
                    children: [
                      Text(car.modele,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),),
                      Text(car.tarification.toString()+" DA",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'Poppins',
                          fontSize: 13,

                        ),),
                    ],
                  ) ,
                ),
                Positioned(
                  bottom:0.0,
                  right: 0.0,
                  child:Column(
                    children:  [
                      FlatButton(
                          onPressed :()async{
                            await userCredentials.refresh();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CarDetail(car: car)),
                            );
                          } ,
                          color: Color(0xff2E9FB0),
                          textColor: Colors.white,
                          minWidth: 140,
                          height: 50,
                          shape:  const RoundedRectangleBorder(
                            borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Text('Details')),

                    ],
                  ) ,
                ),
              ],
            ),
          ),
        ),

      ],

    );
  }
}