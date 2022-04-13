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
    return  Stack(
        children:[

          Container(
            // margin: const EdgeInsets.only(top:40.0,left: 10.0, right: 10.0),
            height: 80,
            width: 80,
            decoration:  BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              color: Colors.transparent,

            ),
            alignment: Alignment.center,
            child:Stack(
              children: [
                Positioned(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(image,width: 50,),
                      Text(titre,style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ),
              ],
            ) ,

          ),]
    );
  }
}