import 'package:autotec/components/text_field_digits.dart';
import 'package:autotec/models/baridimob_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import '../../components/WBack.dart';
import '../../components/raised_button.dart';
import '../../models/baridimob_account.dart';
import '../../models/location.dart';
import '../../models/rest_api.dart';
import '../../car_rental/home_page.dart';

class CodeValidationScreen extends StatefulWidget {
  final CarLocation location;

  const CodeValidationScreen({Key? key, required this.location})
      : super(key: key);

  @override
  CodeValidationScreenState createState() => CodeValidationScreenState();
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
              const SizedBox(height: 15),
              const Text(
                "Voici le code rip que vous devez utiliser dans la transaction",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              textFiedToCopy(ripCopied, _ripController, green, () {
                _copyToClipboard(_ripController);
                setState(() {
                  ripCopied = true;
                });
              }),
              const SizedBox(height: 15),
              const Text(
                "voici l'e-mail auquel vous devez envoyer le reçu ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              textFiedToCopy(emailCopied, _emailController, green, () {
                _copyToClipboard(_emailController);
                setState(() {
                  emailCopied = true;
                });
              }),
              const SizedBox(height: 15),
              const Text(
                "vous pouvez accéder à l'application baridi mob directement à partir d'ici",
                style: TextStyle(
                    fontSize: 15,
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
              const Text(
                "taper ici le code de transaction que vous aver reçu ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
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
                    final response = await Api.verifierPaiementBaridiMob(
                        "baridimob", "10000.0", _codeController.text);
                    widget.location.id_paiement = response;
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

Widget popUP2(
    String title, String content, String buttonText, BuildContext context) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: CustomRaisedButton(
          text: buttonText,
          press: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Map()),
            );
          },
          color: const Color.fromRGBO(27, 146, 164, 0.7),
          textColor: Colors.white,
        ),
      )
    ],
  );
}
