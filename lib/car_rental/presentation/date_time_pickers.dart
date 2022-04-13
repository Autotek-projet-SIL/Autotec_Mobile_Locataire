import 'package:autoteck/DemandeVehicule/DateFin.dart';
import 'package:autoteck/components/WBack.dart';
import 'package:autoteck/components/WraisedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateDebut extends StatefulWidget {
  const DateDebut({Key? key}) : super(key: key);

  @override
  State<DateDebut> createState() => _DateDebutState();
}

class _DateDebutState extends State<DateDebut> {
  DateTime _date= DateTime.now();
  DateTime _time= DateTime.now();
  late String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    WidgetArrowBack(),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Date de Debut',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),)
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text('Selectionner une date',style: TextStyle(fontSize: 18),),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                    initialDateTime: _date,
                    minimumYear: 2020,
                    maximumYear: 2023,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (date){
                      setState(() {
                        _date=date;
                      });

                    }
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                  'Selectionner le temps',
                  style: TextStyle(fontSize: 18)
              ),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                    initialDateTime: _time,
                    minimumYear: 2020,
                    maximumYear: 2023,
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    onDateTimeChanged: (time){
                      setState(() {
                        _time=time;
                      });

                    }
                ),

              ),
              SizedBox(
                height: 20,
              ),
              WidgetRaisedButton(text: 'Continuer',
                  press: (){
                    //print("${_date.day}/${_date.month}/${_date.year}");
                    _date = new DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute, _time.second, _time.millisecond, _time.microsecond);
                    value="${_date.day}/${_date.month}/${_date.year} ${_date.hour}:${_date.minute}";
                    //print(value);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DateFin(dateDeb: value,)),
                    );
                  },
                  color: Color.fromRGBO(27, 146, 164, 0.7),
                  textColor: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

class DateFin extends StatefulWidget {
  final String dateDeb;

  const DateFin( {
    Key? key,
    //  required this.dateDebut,
    required this.dateDeb
  }): super(key: key);

  @override
  State<DateFin> createState() => _DateFinState();
}

class _DateFinState extends State<DateFin> {

  DateTime _date= DateTime.now();
  DateTime _time= DateTime.now();
  late String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    WidgetArrowBack(),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Date de Fin',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),)
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text('Selectionner une date',style: TextStyle(fontSize: 18),),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                    initialDateTime: _date,
                    minimumYear: 2020,
                    maximumYear: 2023,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (date){
                      setState(() {
                        _date=date;
                      });

                    }
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                  'Selectionner le temps',
                  style: TextStyle(fontSize: 18)
              ),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                    initialDateTime: _time,
                    minimumYear: 2020,
                    maximumYear: 2023,
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    onDateTimeChanged: (time){
                      setState(() {
                        _time=time;
                      });

                    }
                ),

              ),
              SizedBox(
                height: 20,
              ),
              WidgetRaisedButton(text: 'Continuer',
                  press: (){
                    _date = DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
                    value="${_date.day}/${_date.month}/${_date.year} ${_date.hour}:${_date.minute}";
                    //print(value);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Demande(dateDebut:widget.dateDeb,dateFin: value,)),
                    );

                  },
                  color: Color.fromRGBO(27, 146, 164, 0.7), textColor: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
