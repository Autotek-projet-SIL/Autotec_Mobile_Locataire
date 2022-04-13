// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'on_boarding.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 146, 164, 1.85),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/logo.png',
                width: 400,
                height: 80,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Don t dream it , Drive it',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'poppins'),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/cover2.png',
              ),
              const SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnBoarding()),
                  );
                },
                color: const Color.fromRGBO(239, 242, 239, 1),
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 13),
                child: const Text(
                  'Continuer',
                  style: TextStyle(
                      color: Color.fromRGBO(1, 42, 43, 1), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
