// ignore_for_file: non_constant_identifier_names, file_names

class PaymentId {
  int? id_payment;

  PaymentId({id_payment}) {
   id_payment = id_payment;
  }
  factory PaymentId.fromJson(Map<String, dynamic> json) =>
      PaymentId(id_payment: json["id_payer"]);
}
