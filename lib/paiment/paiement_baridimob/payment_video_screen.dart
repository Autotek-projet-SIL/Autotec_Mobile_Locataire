import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../components/WBack.dart';
import '../../components/raised_button.dart';
import 'code_validation_screen.dart';

import 'package:firebase_storage/firebase_storage.dart';

class PaymentVideoScreen extends StatefulWidget {
  const PaymentVideoScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PaymentVideoScreenState();
}

class PaymentVideoScreenState extends State<PaymentVideoScreen> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        // we need to get the video from firebase
        'https://firebasestorage.googleapis.com/v0/b/autotek-8c725.appspot.com/o/Paiement%2FBaridi_Mob_Payment_descriptive_video_test.mp4?alt=media&token=330697ab-e51c-40e8-8718-f2c0baeac90e')
      ..initialize().then((_) {
        // Ensure the first frame is shown af
        //ter the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: const [
                    WidgetArrowBack(),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Paiement avec BaridiMob',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'voici une vidéo explicative sur le déroulement du paiement par BaridiMob',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      child: CustomRaisedButton(
                        text: _controller.value.isPlaying ? "stop" : "demarer",
                        press: () => {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          })
                        },
                        color: const Color.fromRGBO(27, 146, 164, 0.7),
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: size.width * 0.2),
                    SizedBox(
                      width: size.width * 0.3,
                      child: CustomRaisedButton(
                        text: "Skip",
                        press: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CodeValidationScreen()),
                          )
                        },
                        color: const Color.fromRGBO(27, 146, 164, 0.7),
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
