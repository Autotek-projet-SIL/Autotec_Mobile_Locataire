// ignore_for_file: avoid_print, prefer_adjacent_string_concatenation

import 'package:enough_mail/enough_mail.dart';
import '../../models/baridimob_payment.dart';
import '../../models/rest_api.dart';
import '../../models/user_data.dart';

//* verification using only flutter */
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

/* Rest apis verifiations */

Future<bool> verifyTeansactionCode(
  BaridiMobPayment baridiMobPayment,
) async {
  await UserCredentials.refresh();
  final response =
      await Api.sendBaridiMobDetails(baridiMobPayment, UserCredentials.token!);
  if (response.statusCode != 200) {
    return false;
  } else {
    return true;
  }
}