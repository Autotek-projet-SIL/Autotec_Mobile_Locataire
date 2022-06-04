import 'package:autotec/components/raised_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/WBack.dart';
import '../../components/text_field.dart';
import '../../models/location.dart';
import '../../models/rest_api.dart';
import 'package:month_year_picker/month_year_picker.dart';

class StripePayment extends StatefulWidget {
  final CarLocation location;

  const StripePayment({Key? key, required this.location})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => StripePaymentState();
}

class StripePaymentState extends State<StripePayment> {
  final _controller = TextEditingController();
  final _numeroCardController = TextEditingController();
  final _cvcController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final items = ["Visa", 'MasterCard', 'American Express'];
  String dropdownValue = "Visa";
  String dateEx = "Date d'éxperation";
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int id_payer;
    return Scaffold(
      body: Column(
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
            const SizedBox(height: 32),
            SizedBox(
              width: (size.width * 0.8) + 5,
              child: const Text(
                "Veuillez entrez les informations de votre carte",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.8 + 5,
                    //  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: ),
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
                                      //trailing: Icon(Icons ),
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
                        height: size.height * 0.07,
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
                          padding: EdgeInsets.all(10),
                          child: (_selected == null)
                              ? const Text("Date d'experation")
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
                         final response = await Api.verifierPaiement(
                            "stripe",
                            "ij_terras@esi.dz",
                            "10",
                            dropdownValue,
                            _numeroCardController.text,
                            DateFormat().add_M().format(_selected!),
                            // "month",
                            DateFormat().add_y().format(_selected!),
                            // "year",
                            _cvcController.text) ;

                        widget.location.id_paiement  = response;
                        Api.endLocation(widget.location);
                      },
                      color: const Color.fromRGBO(27, 146, 164, 0.7),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
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

class PaymentDetails {
  String? paymentType;
  String? email;
  String? cardType;
  String? montant;
  String? cardNumber;
  String? month;
  String? year;
  String? CVC;

  PaymentDetails._privateConstructor();

  static final PaymentDetails _instance = PaymentDetails._privateConstructor();

  factory PaymentDetails() {
    return _instance;
  }
}
