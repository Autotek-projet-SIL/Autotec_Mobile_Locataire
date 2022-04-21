import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:introduction_screen/introduction_screen.dart';
import 'home.dart';

// ignore: use_key_in_widget_constructors
class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Demandez une voiture et elle viendra à vous',
              body:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vel in vitae, sed sem elementum.',
              image: buildImage('assets/phone.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Créer un compte pour continuer',
              body:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vel in vitae, sed sem elementum.',
              image: buildImage('assets/cover2.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Paiement rapide et sécurisé',
              body:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vel in vitae, sed sem elementum.',
              image: buildImage('assets/card.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: const Text('Suivant',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: const Text('Skip'),
          onSkip: () => goToHome(context),
          next: const Text('Suivant'),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => debugPrint('Page $index selected'),
          globalBackgroundColor: Theme.of(context).primaryColor,
          nextFlex: 0,
        ),
      ),
    );
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  PageDecoration getPageDecoration() => const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
        bodyTextStyle: TextStyle(fontSize: 16, fontFamily: "Poppins"),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Home()),
      );
  DotsDecorator getDotDecoration() => DotsDecorator(
        color: const Color(0xFFBDBDBD),
        activeColor: const Color.fromRGBO(27, 146, 164, 1),
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );
}
