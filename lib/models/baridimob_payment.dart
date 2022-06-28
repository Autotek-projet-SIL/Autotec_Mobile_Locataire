import 'dart:core';

class BaridiMobPayment {
  double? montant;
  String? codeTransaction;
  String? datePaiement;
  String? heurPaiement;

  BaridiMobPayment(
      {this.montant,
      this.codeTransaction,
      this.datePaiement,
      this.heurPaiement});
}
