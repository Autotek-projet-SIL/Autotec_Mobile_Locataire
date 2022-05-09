
import 'package:autotec/models/Location.dart';
import 'package:autotec/models/user_data.dart';

import '../components/WraisedButton.dart';
import 'package:flutter/material.dart';




class Demande extends StatefulWidget {

  const Demande( {
    Key? key
  }): super(key: key);

  @override
  State<Demande> createState() => _DemandeState();
}

class _DemandeState extends State<Demande> {

  // ignore: prefer_final_fields
  carLocation _location = carLocation();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height*0.1),
            Image.asset(
              'assets/logo.png',
              width: 350,
            ),
            SizedBox(height: size.height * 0.05),
            const Text('Louer une voiture',
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(_location.point_depart!,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),

                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(20.0),
                      child: Text(_location.point_arrive!,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),

                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(_location.car!.modele!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 20),
            WidgetRaisedButton(text: 'valider',
                press:()async{
              await UserCredentials.refresh();
              print("token\n");
              print(UserCredentials.token);
              print('uid\n');
              print (UserCredentials.uid);
              //TODO post method with the location info
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ),
              );*/
            }, color: const Color(0xff2E9FB0), textColor: Colors.white)


          ],
        ),
      ),
    );
  }

}
