import 'package:enough_mail/enough_mail.dart';
import 'package:flutter/material.dart';

//l'email de l'entreprise
String userName = 'artificcontactpro';
String password = "artific2022";
String domain = 'gmail.com';

// call : await accessMail()
Future<String> accessMail() async {
  String code = "";
  final email = '$userName@$domain';
  final config = await Discover.discover(email);
  if (config == null) {
    print('Unable to auto-discover settings for $email');
    return code;
  }
  final account =
      MailAccount.fromDiscoveredSettings('my account', email, password, config);
  final mailClient = MailClient(account, isLogEnabled: true);
  try {
    await mailClient.connect();
    await mailClient.selectInbox();
    final messages = await mailClient.fetchMessages(count: 10);
    for (MimeMessage message in messages) {
      code = getVerificationCode(message);
      if (code != "") {
        return code;
      }
    }
    await mailClient.startPolling();
  } on MailException catch (e) {
    print('High level API failed with $e');
  }
  return code;
}

String getVerificationCode(MimeMessage message) {
  bool contain = false;
  String code = "";
  //MailAddress sender = MailAddress("BaridiMob", "baridimob@poste.dz");
  MailAddress sender = MailAddress("Sarra BOUZOUL", "is_bouzoul@esi.dz");
  if ((message.isFrom(sender)) &&
      (message.decodeSubject() == "Receipt for operation")) {
    if (message.isTextPlainMessage()) {
      final plainText = message.decodeTextPlainPart();
      if (plainText != null) {
        final lines = plainText.split('\r\n');
        for (final line in lines) {
          RegExp exp = RegExp(
            "\\b" + "Transaction ID: " + "\\b",
            caseSensitive: false,
          );
          contain = exp.hasMatch(line);
          if (contain) {
            code = line.substring(16, 28);
          }
          if (code != "") {
            return code;
          }
        }
      }
    }
  }
  return code;
}
