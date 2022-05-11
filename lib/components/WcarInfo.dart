// ignore_for_file: avoid_unnecessary_containers
// ignore_for_file: file_names

import 'package:flutter/material.dart';


class WidgetCarInfo extends StatelessWidget {
  final String carName;
  final String carPrice;
  final String carImage;
  const WidgetCarInfo({
     Key? key,
    required this.carName,
    required this.carPrice,
    required this.carImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top:40.0,left: 130.0, right: 0.0),
          height: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
            color: Color(0xff2E9FB0),
          ),
          child: Stack(
            children:  [
              Positioned(
                  top:260.0,
                  right: 80,
                  child: Column(
                    children: [
                      Text(carName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20,

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(carPrice,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20,

                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
        Stack(
          children: [
            Positioned(
                top: 110,
                right: 50,
                child: Container(
                  child: Image.asset(carImage,width: 315,),


                ))
          ],
        ),
      ],

    );
  }
}