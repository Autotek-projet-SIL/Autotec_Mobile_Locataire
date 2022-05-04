
import 'package:autotec/models/Location.dart';
import 'package:flutter/material.dart';

import 'package:autotec/models/user_data.dart';
import 'package:autotec/car_rental/demande.dart';
import '../car_rental/Car_details.dart';
import '../car_rental/Cars.dart';


class WidgetViewCar extends StatelessWidget {
  final Car car;

  const WidgetViewCar({
    Key? key,
    required this.car
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: ()async{
            await userCredentials.refresh();
            carLocation _location = carLocation();
            _location.car = car;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Demande()),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top:10.0, left: 10.0, right: 10.0),
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
                  offset: Offset(0,2), // changes position of shadow
                ),
              ],
              color: Colors.white,
            ),
            child: Stack(
              children:  [
                Positioned(
                  top:10.0,
                  left: 10.0,
                  child: Image.network(car.image!,width: 120),
                ),
                Positioned(
                  top:10.0,
                 left: 145,
                  child:
                      Container(
                        height: 50,
                        width: 150,
                        child: Text(car.modele!,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),),
                      ),
                ),
                Positioned(
                  bottom: 10,
                  left: 50,
                  child: Text(car.tarification.toString()+" DA",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13,

                  ),),),
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