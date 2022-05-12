/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Stripe_test extends StatelessWidget {
  const Stripe_test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stripe.publishableKey = "pk_test_51KtJjXD9GU8MlLburJtDX95OQF7ORfhR4t0YtH6vYua8UK2a6CsCG4x5twd4xK6mvwVGe9HOVhrTUkl1agg9USrZ00LDllkrLQ";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Payments'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  transform: GradientRotation(20),
                  colors: <Color>[
                    Color(0xFF439cfb),
                    Color(0xFFf187fb),
                  ],
                ),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  final url = Uri.parse(
                      "http://192.168.34.108:3000/?amount=7000&currency=dzd");
                  final response = await http.get(url);
                  print(response.body);
                  var jsonBody = jsonDecode(response.body);
                  Map<String, dynamic>? paymentIntentData;
                  paymentIntentData = jsonBody;
                  if (paymentIntentData!["paymentIntent"] != "" &&
                      paymentIntentData["paymentIntent"] != null) {
                    String _intent = paymentIntentData["paymentIntent"];
                    await Stripe.instance.initPaymentSheet(
                      paymentSheetParameters: SetupPaymentSheetParameters(
                        paymentIntentClientSecret: _intent,
                        applePay: false,
                        googlePay: false,
                        merchantCountryCode: "IN",
                        merchantDisplayName: "Test",
                        testEnv: false,
                        customerId: paymentIntentData['customer'],
                        customerEphemeralKeySecret:
                        paymentIntentData['ephemeralKey'],
                      ),
                    );

                    await Stripe.instance.presentPaymentSheet();
                  }
                },
                child: const Text(
                  'Stripe',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/