import 'package:flutter/material.dart';


class WidgetCarInfo extends StatelessWidget {
  final String carName;
  final String carPrice;
  final String carImage;
  const WidgetCarInfo({
    Key? key,
    required this.carName,
    required this.carPrice,
    required this.carImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [

        Container(
          margin: const EdgeInsets.only(top:40.0,left: 130.0, right: 0.0),
          height:size.height*0.48,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
            color: Color(0xff2E9FB0),
          ),
          child: Stack(
            children:  [
              Positioned(
                top:size.height*0.33,
                right: 5,
                child: Column(
                  children: [
                    SizedBox(
                      width:200,
                      child: Text(carName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 18,

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(carPrice,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16,

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: size.height*0.09,
          right: 10,
          child: Container(
            child: Image.network(carImage,width: 330,),
          ),
        ),

      ],
    );
  }
}