// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WidgetCarSpecifications extends StatelessWidget {
  final String titre;
  final String image;
  const WidgetCarSpecifications({
    Key? key,
    required this.titre,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(5),
            topLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          color: Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    width: 50,
                  ),
                  Text(
                    titre,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
