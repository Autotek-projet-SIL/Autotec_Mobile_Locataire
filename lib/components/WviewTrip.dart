import 'package:flutter/material.dart';


class WidgetViewTrip extends StatelessWidget {
  final String carName;
  final String carPrice;
  final String start;
  final String end;
  const WidgetViewTrip({
    Key? key,
    required this.carName,
    required this.carPrice,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top:40.0,left: 10.0, right: 10.0),
          height: 170,
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
                  top:15.0,
                  left: 15.0,
                  child: Column(
                    children: [
                      Text(carName,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 20,

                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          children:[
                            Image.asset('assets/a.png',),
                            const SizedBox(width: 20,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(start,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,

                                  ),

                                ),
                                const SizedBox(height: 10,),
                                Text(end,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,

                                  ),),
                              ],
                            ),]
                      ),
                    ],
                  )),
              Positioned(
                top:15.0,
                right: 15.0,
                child:Column(
                  children: [
                    Text(carPrice,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 20,

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
                        color: const Color(0xff2E9FB0),
                        textColor: Colors.white,
                        minWidth: 140,
                        height: 50,
                        shape:  const RoundedRectangleBorder(
                          borderRadius:  BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: const Text('Details')),

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