import '../../models/rest_api.dart';
import '../../models/user_data.dart';

Future<bool> verifyTeansactionCode(
  String code,
) async {
  await UserCredentials.refresh();
  final response = await Api.sendBaridiMobDetails(code, UserCredentials.token!);
  if (response.statusCode != 200) {
    return false;
  } else {
    return true;
  }
}
