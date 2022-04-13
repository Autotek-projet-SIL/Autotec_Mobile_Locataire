import 'dart:convert';

import 'package:autotec/Authentication/data/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Cars.dart';
import '/components/WviewCar.dart';
import '../../Authentication/data/models/user_data.dart';



class CarsList extends StatefulWidget {
  const CarsList({Key? key}) : super(key: key);

  @override
  State<CarsList> createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:const [
          Spacer(flex: 1,),
          Text(
            'Choisir un type de voiture',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          Spacer(flex: 1,),
          Center(

            child: SizedBox(
                height: 500,
                width: 300,
                child: CarListView()),
          ),
          Spacer(flex: 1,),
        ],
      ),
    );
  }
}

class CarListView extends StatelessWidget{
  const CarListView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Car>>(
      future: _fetchCars(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Car>? data = snapshot.data;
          return _CarsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
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

  ListView _CarsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return WidgetViewCar(car:data[index]);
        });
  }
}