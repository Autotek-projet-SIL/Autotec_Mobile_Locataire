
// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

import '../components/WBack.dart';


class FactureDetails extends StatefulWidget {
  final String nomLoc;
 final String numeroChassis;
 final String heureDebut;
 final String heureFin;
 final String region;
 final DateTime dateDebut;
 final int idFacture;
//  DateTime dateFacture;
  final int montant;
  // String heure;
  final String marque;
  final String modele;
  //String couleur;
  //String imageVehicule;
  const FactureDetails({
    Key? key,
    required this.nomLoc,
    required this.numeroChassis,
    required this.heureDebut,
    required this.heureFin,
    required this.region,
    required this.dateDebut,
    required this.idFacture,
    required this.montant,
    required this.marque,
    required this.modele,
  }) : super(key: key);


  @override
  State<FactureDetails> createState() => _FactureDetailsState();
}

class _FactureDetailsState extends State<FactureDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: const [
                  WidgetArrowBack(),
                  SizedBox(width: 10,),
                  Text(
                      "Details de la facture ",
                  //  textAlign: TextAlign.center,
                     style:TextStyle(fontWeight:FontWeight.bold,fontSize: 24,color: Color(0xff2E9FB0)),),
                ],
              ),
              SizedBox(height: size.height*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.nomLoc.toUpperCase(),
                    textAlign: TextAlign.center,
                    style:TextStyle(fontSize: 22),),
                  Image.asset("assets/logo.png",width: 120,)
                ],
              ),
              SizedBox(height: size.height*0.03,),
              Text(
                "Informations facture : ",
                textAlign: TextAlign.center,
                style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Color(0xff2E9FB0),),),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(" N° : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                      Text("${widget.idFacture}", textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                    ],),
                    SizedBox(height: size.height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Date : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        Text("${widget.dateDebut.day}-${widget.dateDebut.month}-${widget.dateDebut.year}", textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                      ],),
                    SizedBox(height: size.height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Heure : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        Text(widget.heureDebut, textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                      ],)

                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.all(5),
                  height: 55,
                  width: size.width*0.7,
                  decoration: const BoxDecoration(
                    color: Color(0xff9AD4E2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Prix Total :",
                        textAlign: TextAlign.center,
                        style:TextStyle(fontSize: 21,color: Color(0xff042A2B),fontWeight: FontWeight.bold)),
                      SizedBox(width: 5,),
                      Text(
                        "${widget.montant} DA",
                        textAlign: TextAlign.center,
                        style:TextStyle(fontSize: 24,color: Color(0xff042A2B)),)
                    ],
                  )
              ),
              SizedBox(height: size.height*0.03,),
              const Divider(
                thickness: 1,
                indent: 18,
                endIndent: 18,
                color: Colors.black,
                height: 25,
              ),
              Text(
                "Informations trajet : ",
                textAlign: TextAlign.center,
                style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Color(0xff2E9FB0),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  children: [
                   /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" De : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        Text(" ${widget.region}", textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                      ],),
                    SizedBox(height: size.height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" à : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        Text(" ${widget.region}", textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                      ],),
                    SizedBox(height: size.height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Date : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        Text("${widget.dateDebut.day}-${widget.dateDebut.month}-${widget.dateDebut.year}", textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                      ],),
                    SizedBox(height: size.height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Heure depart : : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        Text("${widget.heureDebut}", textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                      ],),
                    SizedBox(height: size.height*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Heure arrivée : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        Text("${widget.heureFin}", textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                      ],)*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Image.asset('assets/a.png',width: 65,),
                          // SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text("${widget.dateDebut.day}-${widget.dateDebut.month}-${widget.dateDebut.year} ${widget.heureDebut}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,

                                ),

                              ),
                              SizedBox(height: 5,),
                              Text(widget.region ,style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 30,),
                              Text("${widget.dateDebut.day}-${widget.dateDebut.month}-${widget.dateDebut.year} ${widget.heureFin}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,

                                ),),
                              SizedBox(height: 5,),
                              Text(widget.region ,style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),]
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height*0.03,),
              const Divider(
                thickness: 1,
                indent: 18,
                endIndent: 18,
                color: Colors.black,
                height: 25,
              ),
              const Text(
                "Informations véhicule : ",
                textAlign: TextAlign.center,
                style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Color(0xff2E9FB0),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Column(
                  children: [
                    Column(
                      children: [                     
                        Text(" Numero de chasis : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        SizedBox(height: size.height*0.008,),
                        Text(widget.numeroChassis, textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                      ],
                    ),

                    SizedBox(height: size.height*0.02,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Type de vehicule : ", textAlign: TextAlign.center,style:TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        SizedBox(height: size.height*0.008,),
                        Text("${widget.marque} ${widget.modele}", textAlign: TextAlign.center,style:TextStyle(fontSize: 19)),
                      ],),
                    SizedBox(height: size.height*0.03,),
                    const Divider(
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black,
                      height: 25,
                    ),
                    Text("Merci pour ")
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}