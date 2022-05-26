import 'package:autotec/payment/paiement_baridimob/payment_video_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/raised_button.dart';
import '../models/location.dart';



// ignore: must_be_immutable
class PaimentMethodeScreen extends StatelessWidget {
  CarLocation location;
  PaimentMethodeScreen({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Body());
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Paiement",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              Text(
                "Veuillez choisir la methode de paiement qui vous convient",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32),
              CustomRaisedButton(
                text: "Carte Edahabia (BaridiMob)",
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentVideoScreen()),
                ),
                color: const Color.fromRGBO(27, 146, 164, 0.7),
                textColor: Colors.white,
              ),
              const SizedBox(height: 32),
              CustomRaisedButton(
                text: "Carte de credit",
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentVideoScreen()),
                ),
                color: const Color.fromRGBO(27, 146, 164, 0.7),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
