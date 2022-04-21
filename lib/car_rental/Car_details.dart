import 'package:flutter/material.dart';
import 'Cars.dart';

class CarDetail extends StatefulWidget {
  final Car car ;
  const CarDetail( {Key? key, required this.car}) : super(key: key);

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
