// ignore_for_file: file_names

import 'package:flutter/material.dart';


class WidgetArrowBack extends StatelessWidget {

  const WidgetArrowBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Stack(
        children:[

          InkWell(
            child: Container(          
              height: 40,
              width: 40,
              decoration:  const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Color(0xff2E9FB0),

              ),

              alignment: Alignment.center,
              child:Stack(
                children: const [
                  Positioned(
                    child:
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20.0,


                    ),
                  ),
                ],
              ) ,

            ),
            onTap: () => Navigator.of(context).pop(),
          ),]
    );
  }
}