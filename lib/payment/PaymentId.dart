// ignore_for_file: non_constant_identifier_names
// ignore_for_file: file_names


class PaymentId {
  // the info related to the location
  int? id_payment;

  PaymentId({id_payment})
  {
    this.id_payment = id_payment;
  }
  factory PaymentId.fromJson(Map<String, dynamic> json) => PaymentId(
      id_payment : json["id_payer"]
  );
}
