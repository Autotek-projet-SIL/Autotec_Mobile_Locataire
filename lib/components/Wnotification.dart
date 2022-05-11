// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';


class WidgetNotification extends StatelessWidget {
  final String titre;
  final String texte;
  final String time;
  const WidgetNotification({
    Key? key,
    required this.titre,
    required this.texte,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top:40.0,left: 10.0, right: 10.0),
            height: 150,
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
              children: [

                Positioned(
                  top:15,
                  left: 15,
                  child:  Text(titre,style: const TextStyle(color: Color(0xff263238),fontWeight: FontWeight.bold,fontSize: 17),),
                ),
                Positioned(
                  top:50,
                  left: 20,
                  child:  Container(
                    width: 350,
                    child: Text(
                      texte,style: const TextStyle(color:Color(0xff263238),fontSize: 15),),
                  ),
                ),
                Positioned(
                  top:15,
                  right: 30,
                  child:  Text(time,style: const TextStyle(fontSize: 15,color:  Color(0xff263238)),),
                )
              ],
            ),


          )
        ]
    );
  }
}