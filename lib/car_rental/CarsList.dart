import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Cars.dart';
import '/components/WviewCar.dart';
import 'package:autotec/models/user_data.dart';



class CarsList extends StatefulWidget {
  final double lat;
  final double long;
  final String Debut;
  final String Fin;
   CarsList({Key? key, required this.lat, required this.long,required this.Debut, required this.Fin}) : super(key: key);

  @override
  State<CarsList> createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(flex: 1,),
          Text(
            'Choisir un type de voiture',
            style: TextStyle(
              fontFamily: 'poppin',
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Spacer(flex: 1,),
          Center(

            child: SizedBox(
                height: 550,
                width: 300,
                child: CarListView(latitude:widget.lat,longitude: widget.long ,DateDebut: widget.Debut, DateFin: widget.Fin,)),
          ),
          Spacer(flex: 1,),
        ],
      ),
    );
  }
}

class CarListView extends StatelessWidget{
  final double latitude;
  final double longitude;
  final String DateDebut;
  final String DateFin;
  CarListView({Key? key, required this.latitude,  required this.longitude, required this.DateDebut, required this.DateFin}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Car>>(
      future: _fetchCars(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Car>? data = snapshot.data;
          return _CarsListView(data,this.DateDebut, this.DateFin, this.latitude, this.longitude);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return SizedBox(
          height: 10,
            width: 10,
            child: CircularProgressIndicator());
      },
    );
  }

  Future<List<Car>> _fetchCars() async {

    var Url = Uri.http("autotek-server.herokuapp.com","/flotte/vehicule");
    print (Url.toString());
    final response = await http.get(Url, headers: {'token':userCredentials.token!,'id_sender':userCredentials.uid!});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => new Car.fromJson(json)).toList();
    } else if (response.statusCode == 403) {
      throw Exception('access forbiden');
    }else{

      throw Exception('Failed to load Cars from API');
    }
  }

  ListView _CarsListView(data, dateD, dateF, latitude, longitude) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return WidgetViewCar(car:data[index], DateDebut:dateD, DateFin: dateF, latitude: latitude, longitude: longitude);
        });
  }
}