import 'package:flutter/material.dart';


class WidgetViewCar extends StatelessWidget {
  final String carName;
  final String carPrice;
  final String carImage;
  const WidgetViewCar({
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
                child: Image.network(carImage,width: 120),
              ),
              Positioned(
                top:25.0,
               left: 145,
                child:Column(
                  children: [
                    Text(carName,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),),
                    Text(carPrice,
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
                        onPressed :(){} ,
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

      ],

    );
  }
}