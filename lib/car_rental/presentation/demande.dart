import 'package:autoteck/components/WraisedButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class Demande extends StatefulWidget {
  final String dateDebut;
  final String dateFin;

  const Demande( {
    Key? key,
    required this.dateDebut,
    required this.dateFin
  }): super(key: key);

  @override
  State<Demande> createState() => _DemandeState();
}

class _DemandeState extends State<Demande> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height*0.1),
            Image.asset(
              'assets/logo.png',
              width: 350,
            ),
            SizedBox(height: size.height * 0.05),
            Text('Louer une voiture',
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text('votre position actuelle'),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 50,
                  width: size.width*0.4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff2E9FB0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_sharp,
                          color: Color(0xff2E9FB0),
                          size: 12.0,
                        ),
                        SizedBox(width: 3,),
                        Text(widget.dateDebut,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size.width*0.06,),
                Container(
                  height: 50,
                  width: size.width*0.4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:Color(0xff2E9FB0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_sharp,
                          color: Color(0xff2E9FB0),
                          size: 12.0,
                        ),
                        SizedBox(width: 3,),
                        Text(widget.dateFin,textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff2E9FB0),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text('Type vehicule'),
              ),
            ),
            SizedBox(height: 20),
            WidgetRaisedButton(text: 'Trouver une voiture', press:(){}, color: Color(0xff2E9FB0), textColor: Colors.white)

          ],
        ),
      ),
    );
  }
}
