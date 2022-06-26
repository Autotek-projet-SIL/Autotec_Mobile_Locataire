// ignore_for_file: deprecated_member_use, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:autotec/models/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/rest_api.dart';
import 'Cars.dart';
import '/components/WviewCar.dart';
import 'package:autotec/models/user_data.dart';

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
        children: const [
          Spacer(
            flex: 2,
          ),
          Text(
            'Veuillez choisir une voiture',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Center(
            child: CarListView(),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class CarListView extends StatelessWidget {
  const CarListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Car>>(
      future: _fetchCars(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Car>? data = snapshot.data;
          return SizedBox(height: 550, width: 350, child: _CarsListView(data));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<void> _showFailDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: SizedBox(
              height: 160,
              width: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      child: Text(
                          "aucune voiture n'est disponible en ce moment, veuillez réessayer plus tard")),
                  Center(
                    child: FlatButton(
                        onPressed: () {
                          CarLocation _location = CarLocation();
                          Api.postLocationRejected();
                          Navigator.pop(context);
                        },
                        child: const Text("ok")),
                  )
                ],
              ),
            )),
          );
        });
  }

  Future<List<Car>> _fetchCars(BuildContext context) async {
    var Url = Uri.http("autotek-server.herokuapp.com", "/flotte/vehicule");
    print(Url.toString());
    final response = await http.get(Url, headers: {
      'token': UserCredentials.token!,
      'id_sender': UserCredentials.uid!
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Car> list = jsonResponse.map((json) => Car.fromJson(json)).toList();
      //recuperer ceux dispo et batterie > 20
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('CarLocation')
            .where('batterie', isGreaterThan: 20)
            .where('disponible', isEqualTo: true)
            .get();
        list.removeWhere((element) =>
            (!querySnapshot.docs.any((doc) => doc.id == element.numeroChasis)));
      } catch (e) {
        print(e.toString());
      }

      if (list.isEmpty) {
        _showFailDialog(context);
      }
      return list;
    } else if (response.statusCode == 403) {
      throw Exception('access forbiden');
    } else {
      throw Exception('Failed to load Cars from API');
    }
  }

  ListView _CarsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return WidgetViewCar(car: data[index]);
        });
  }
}
