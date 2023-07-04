import 'dart:math';

class UtilityMethods {
  // Remove + from phone number
  static String removePlus(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'\+'), '');
  }

  // Create a random code for forgot password
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random rnd = Random();
  static String randomCode() => String.fromCharCodes(Iterable.generate(
      6, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));
}
