import 'package:autotec/components/WBack.dart';
import 'package:autotec/components/WcarSpecifications.dart';
import 'package:autotec/components/WraisedButton.dart';
import 'package:autotec/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/WcarInfo.dart';
import 'Cars.dart';

class CarDetail extends StatefulWidget {
  final Car car ;
  const CarDetail( {Key? key, required this.car, }) : super(key: key);

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {

  var _carLocation;
  bool circular =true;
  void initState(){
    super.initState();
    getCarFromFirestore();
  }
  void getCarFromFirestore() async{
    try{
      DocumentSnapshot variable=await FirebaseFirestore.instance.collection('CarLocation').doc(widget.car.numeroChassis).get();

      setState(() {
        _carLocation=variable;
        circular=false;
      });
    }catch(e){
      print(e.toString());

    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 10,bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WidgetArrowBack(),
                    SizedBox(width: 10,),
                    Text("${widget.car.marque}".toUpperCase(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              WidgetCarInfo(carName: "${widget.car.modele}", carPrice:  "${widget.car.tarification} DA", carImage:  "${widget.car.imageVehicule}"),
              SizedBox(height: size.height*0.03,),
              Text("Specifications: ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
              SizedBox(height: size.height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  circular?CircularProgressIndicator(): WidgetCarSpecifications(titre: "${_carLocation['batterie']}%",image: "assets/battery.png",),
                  circular?CircularProgressIndicator():  WidgetCarSpecifications(titre: "${_carLocation['temperature']}°",image: "assets/temp.png",),
                  circular?CircularProgressIndicator(): WidgetCarSpecifications(titre: "${_carLocation['kilometrage']}km/h",image: "assets/speed.png",),
                ],
              ),
              SizedBox(height: size.height*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.directions_car_rounded,color:Color(0xff2E9FB0)),
                      SizedBox(width: 5,),
                      Text('${widget.car.couleur}')
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/circulation.png"),
                      SizedBox(width: 5,),
                      Text('${widget.car.libelle}')
                    ],
                  ),

                ],
              ),
              SizedBox(height: size.height*0.03,),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text("Localisation : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height: size.height*0.02,),
                    Row(
                      children: [
                        Icon(Icons.location_on ,color:Color(0xff2E9FB0) ,),
                        SizedBox(height: 5,),
                        Text("Oued Smar, Alger ,Algerie",style: TextStyle(fontSize: 16),),
                      ],
                    ),
                    SizedBox(height: size.height*0.03,),
                    Text("Agent de maintenance : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height: size.height*0.02,),
                    Row(
                      children: [
                        Icon(Icons.person,color: Color(0xff2E9FB0),),
                        SizedBox(width: 10,),
                        Text("${widget.car.nom} ${widget.car.prenom}".toUpperCase()),
                      ],
                    ),
                    SizedBox(height: size.height*0.02,),
                    Row(
                      children: [
                        Icon(Icons.phone,color: Color(0xff2E9FB0),),
                        SizedBox(width: 10,),
                        Text("${widget.car.numeroTelephone}"),
                      ],
                    ),
                    SizedBox(height: size.height*0.02,),
                    Row(
                      children: [
                        Icon(Icons.email,color: Color(0xff2E9FB0),),
                        SizedBox(width: 10,),
                        Text("${widget.car.email} ")
                      ],
                    ),
                    SizedBox(height: size.height*0.03,),

                    WidgetRaisedButton(text: "Louer", press: () async {

                    },color: Color(0xff2E9FB0),textColor: Colors.white,),
                  ],
                ),
              ),

            ],
          ),
        )
    );
  }
}
