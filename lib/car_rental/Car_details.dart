// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_string_interpolations, file_names

import 'package:autotec/components/WBack.dart';
import 'package:autotec/components/WcarSpecifications.dart';
import 'package:autotec/components/WraisedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/WcarInfo.dart';
import 'Cars.dart';

class CarDetail extends StatefulWidget {
  final Car car;

  const CarDetail({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  var _carLocation;
  bool circular = true;

  @override
  void initState() {
    super.initState();
    getCarFromFirestore();
  }

  void getCarFromFirestore() async {
    try {
      DocumentSnapshot variable = await FirebaseFirestore.instance
          .collection('CarLocation')
          .doc(widget.car.numeroChasis)
          .get();

      setState(() {
        _carLocation = variable;
        circular = false;
      });
    } catch (e) {
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
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const WidgetArrowBack(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.car.marque}".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          WidgetCarInfo(
              carName: "${widget.car.modele}",
              carPrice: "${widget.car.tarification} DA",
              carImage: "${widget.car.image}"),
          SizedBox(
            height: size.height * 0.03,
          ),
          const Text(
            "Specifications: ",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              circular
                  ? const CircularProgressIndicator()
                  : WidgetCarSpecifications(
                      titre: "${_carLocation['batterie']}%",
                      image: "assets/battery.png",
                    ),
              circular
                  ? const CircularProgressIndicator()
                  : WidgetCarSpecifications(
                      titre: "${_carLocation['temperature']}°",
                      image: "assets/temp.png",
                    ),
              circular
                  ? const CircularProgressIndicator()
                  : WidgetCarSpecifications(
                      titre: "${_carLocation['kilometrage']}km/h",
                      image: "assets/speed.png",
                    ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Icon(Icons.directions_car_rounded,
                      color: Color(0xff2E9FB0)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('${widget.car.libelle}')
                ],
              ),
              Row(
                children: [
                  Image.asset("assets/circulation.png"),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('${widget.car}')
                ],
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Text(
                  "Localisation : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xff2E9FB0),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Oued Smar, Alger ,Algerie",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Text(
                  "Agent de maintenance : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Color(0xff2E9FB0),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                        "${widget.car.nom} ${widget.car.prenom}".toUpperCase()),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Color(0xff2E9FB0),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("${widget.car.numeroTelephone}"),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: Color(0xff2E9FB0),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("${widget.car.email} ")
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                WidgetRaisedButton(
                  text: "Louer",
                  press: () async {},
                  color: const Color(0xff2E9FB0),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
