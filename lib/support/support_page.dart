import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/WBack.dart';
import '../components/raised_button.dart';
import '../components/text_field.dart';
import '../models/rest_api.dart';

class DemandeSupportScreen extends StatefulWidget {
  final int id_louer;
  const DemandeSupportScreen({Key? key, required this.id_louer}) : super(key: key);

  @override
  State<DemandeSupportScreen> createState() => _DemandeSupportScreenState();
}

class _DemandeSupportScreenState extends State<DemandeSupportScreen> {
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _objetcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Demande de support',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Veuillez saisir votre email, l'objet et la description ",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                hintText: " Votre email",
                controler: _emailController,
                validationMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return value != null && !EmailValidator.validate(value)
                      ? 'Enter a  valid email'
                      : null;
                },
              ),
              const SizedBox(height: 32),
              CustomTextField(
                hintText: "Objet..",
                controler: _objetcontroller,
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 100,
                child: _longtextfield(
                    size, "Description..", _descriptioncontroller),
              ),
              const SizedBox(height: 32),
              CustomRaisedButton(
                text: " Envoyer ",
                press: () async {
                  final response =
                      await Api.addDemandeSupport(_descriptioncontroller.text, _objetcontroller.text, _emailController.text,  widget.id_louer);
                  if(response.statusCode == 200){
                    print("la demande de support a été créee avec succes");
                  }
                  },
                color: const Color.fromRGBO(27, 146, 164, 0.7),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _longtextfield(
      Size size, String hint, TextEditingController _controller) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 3, color: Color.fromRGBO(27, 146, 164, 1)),
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.all(14.0),
      ),
      style: const TextStyle(
        height: 6.0,
      ),
    );
  }
}
