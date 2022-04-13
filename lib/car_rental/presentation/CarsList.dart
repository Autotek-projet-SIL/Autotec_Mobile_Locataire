import 'dart:convert';

import 'package:autotec/Authentication/data/models/user_data.dart';
import 'package:autotec/car_rental/presentation/date_time_pickers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Cars.dart';
import '/components/WviewCar.dart';
import '../../Authentication/data/models/user_data.dart';



class CarsList extends StatefulWidget {
  final String Debut;
  final String Fin;
   CarsList({Key? key, required this.Debut, required this.Fin}) : super(key: key);

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
                child: CarListView(DateDebut: widget.Debut, DateFin: widget.Fin,)),
          ),
          Spacer(flex: 1,),
        ],
      ),
    );
  }
}

class CarListView extends StatelessWidget{
  final String DateDebut;
  final String DateFin;
  CarListView({Key? key, required this.DateDebut, required this.DateFin}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Car>>(
      future: _fetchCars(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Car>? data = snapshot.data;
          return _CarsListView(data,this.DateDebut, this.DateFin);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator(strokeWidth: 10,);
      },
    );
  }

  Future<List<Car>> _fetchCars() async {

    var Url = Uri.http("autotek-server.herokuapp.com","/flotte/vehicule");
    print (Url.toString());
    final response = await http.get(Url, headers: {'token':userCredentials.token!,'id':userCredentials.uid!});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => new Car.fromJson(json)).toList();
    } else if (response.statusCode == 403) {
      throw Exception('access forbiden');
    }else{

      throw Exception('Failed to load Cars from API');
    }
  }

  ListView _CarsListView(data, dateD, dateF) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return WidgetViewCar(car:data[index], DateDebut:dateD, DateFin: dateF);
        });
  }
}