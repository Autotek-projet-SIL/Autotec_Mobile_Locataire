import 'package:autotec/components/text_field_digits.dart';
import 'package:autotec/models/baridimob_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import '../../components/WBack.dart';
import '../../components/raised_button.dart';
import '../../models/baridimob_account.dart';
import 'email.dart';

class CodeValidationScreen extends StatefulWidget {
  const CodeValidationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CodeValidationScreenState();
}

class CodeValidationScreenState extends State<CodeValidationScreen> {
  //payment
  BaridiMobPayment? baridiMobPayment;
  // text controllers
  final TextEditingController _ripController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // variables for UI purposes
  static bool ripCopied = false;
  static bool emailCopied = false;
  static const Color green = Color.fromRGBO(27, 146, 164, 0.7);

  Future<void> _copyToClipboard(TextEditingController controller) async {
    await Clipboard.setData(ClipboardData(text: controller.text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copié dans le presse-papier'),
      elevation: 3,
      backgroundColor: Color.fromRGBO(27, 146, 164, 0.7),
      behavior: SnackBarBehavior.floating,
      width: 300,
    ));
  }

  @override
  void initState() {
    super.initState();
    _ripController.text = BaridiMobAccount().rip;
    _emailController.text = BaridiMobAccount().email;
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
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
                      'Validation',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Voici le code rip que vous devez utiliser dans la transaction",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              textFiedToCopy(ripCopied, _ripController, green, () {
                _copyToClipboard(_ripController);
                setState(() {
                  ripCopied = true;
                });
              }),
              const SizedBox(height: 40),
              const Text(
                "voici l'e-mail auquel vous devez envoyer le reçu ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              textFiedToCopy(emailCopied, _emailController, green, () {
                _copyToClipboard(_emailController);
                setState(() {
                  emailCopied = true;
                });
              }),
              const SizedBox(height: 40),
              const Text(
                "vous pouvez accéder à l'application baridi mob directement à partir d'ici",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomRaisedButton(
                  text: "Entrer dans l'application BaridiMob ",
                  press: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'ru.bpc.mobilebank.bpc',
                    );
                  },
                  color: const Color.fromRGBO(27, 146, 164, 0.7),
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "taper ici le code de transaction que vous aver reçu ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              WidgetTextfieldDigit(
                  hintText: "Code de transaction",
                  onChanged: (String text) {},
                  validator: (value) {
                    return value != null && value.length < 12
                        ? "le code ne contient que des chiffres"
                        : null;
                  },
                  controller: _codeController,
                  validationMode: AutovalidateMode.onUserInteraction),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomRaisedButton(
                  text: "Confirmer",
                  press: () async {
                    DateTime date = DateTime.now();
                    baridiMobPayment!.codeTransaction = _codeController.text;
                    baridiMobPayment!.datePaiement =
                        "${date.hour}:${date.minute}:${date.second}";
                    baridiMobPayment!.heurPaiement =
                        "${date.hour}:${date.minute}:${date.second}";

                    verifyTeansactionCode(baridiMobPayment!);
                    (_codeController.text == await accessMail())
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return popUP("Merci !! ",
                                  "Nous avons bien reçu votre paiement ", "Ok");
                            },
                          )
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return popUP(
                                  "Erreur !! ",
                                  " Le code que vous avez saisi ne correspond à aucune transaction",
                                  "Retour");
                            },
                          );
                  },
                  color: const Color.fromRGBO(27, 146, 164, 0.7),
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textFiedToCopy(bool pressed, TextEditingController _textController,
    Color green, VoidCallback _copyToClipboard) {
  return TextField(
    style: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
    controller: _textController,
    readOnly: true,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 3,
          color: pressed ? green : Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 3,
          color: pressed ? green : Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.all(14.0),
      icon: IconButton(
        icon: Icon(
          Icons.copy,
          color: pressed ? green : Colors.black,
        ),
        onPressed: _copyToClipboard,
      ),
    ),
  );
}

Widget popUP(String title, String content, String buttonText) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: CustomRaisedButton(
          text: buttonText,
          press: () async {},
          color: const Color.fromRGBO(27, 146, 164, 0.7),
          textColor: Colors.white,
        ),
      )
    ],
  );
}