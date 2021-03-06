import 'package:autotec/components/raised_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/WBack.dart';
import '../../components/text_field.dart';
import '../../models/location.dart';
import '../../models/rest_api.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../../models/user_data.dart';
import '../paiement_baridimob/code_validation_screen.dart';

class StripePayment extends StatefulWidget {
  final CarLocation location;

  const StripePayment({Key? key, required this.location}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StripePaymentState();
}

class StripePaymentState extends State<StripePayment> {
  final _numeroCardController = TextEditingController();
  final _cvcController = TextEditingController();
  final _paiementKey = GlobalKey<FormState>();

  final items = ["Visa", 'MasterCard', 'American Express'];
  String dropdownValue = "Visa";
  String dateEx = "Date d'√©xperation";
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  Text('Paiement',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'))
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: (size.width * 0.8) + 5,
              child: const Text(
                "Veuillez entrez les informations de votre carte",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _paiementKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.8 + 5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black, width: 3)),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      onChanged: (value) =>
                          setState(() => dropdownValue = value!),
                      items: items
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: ListTile(
                                      title: Text(value),
                                    ),
                                  ))
                          .toList(),
                      iconSize: 42,
                      underline: SizedBox(
                        width: size.width * 0.8 + 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: size.width * 0.8 + 5,
                    child: CustomTextField(
                      hintText: "Numero de la carte",
                      controler: _numeroCardController,
                      validationMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return value != null && value.length < 16
                            ? 'Enter a valid acount'
                            : null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    GestureDetector(
                      child: Container(
                        height: size.height * 0.068,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 3,
                              color: (_selected == null)
                                  ? Colors.black
                                  : const Color.fromRGBO(27, 146, 164, 0.7),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: (_selected == null)
                              ? const Text("Date d'expiration")
                              : Text(DateFormat().add_yM().format(_selected!)),
                        ),
                      ),
                      onTap: () {
                        _onPressed(context: context);
                      },
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: size.width * 0.2,
                      height: size.height * 0.07,
                      child: CustomTextField(
                        hintText: "CVC",
                        controler: _cvcController,
                        validationMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value != null && value.length > 3
                              ? '3 chiffres seulement'
                              : null;
                        },
                      ),
                    )
                  ]),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: size.width * 0.8,
                    height: size.height * 0.05,
                    child: CustomRaisedButton(
                      text: "Confirmer",
                      press: () async {
                        final response = await Api.verifierPaiementStripe(
                            "stripe",
                            widget.location.montant.toString(),
                            dropdownValue,
                            _numeroCardController.text,
                            DateFormat().add_M().format(_selected!),
                            DateFormat().add_y().format(_selected!),
                            _cvcController.text);
                        widget.location.id_paiement = response;                        
                        UserCredentials.refresh();
                        Api.endLocation(widget.location);
                        await updates2();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return popUP2(
                                "Merci!",
                                "Nous avons bien re√ßu votre paiement ",
                                "Ok",
                                context);
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
          ]),
    ));
  }

  Future<void> updates2() async {
    var db =  FirebaseFirestore.instance;
    final docRef =
        db.collection('CarLocation').doc(widget.location.car!.numeroChasis);
    final data = {'arrive': false};
    docRef.set(data, SetOptions(merge: true));
    Api.updateLocationState("fin", widget.location.id_location!);
  }

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      locale: localeObj,
    );
    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }
}
