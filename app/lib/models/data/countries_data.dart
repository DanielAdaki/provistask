import 'dart:convert';

import 'package:http/http.dart' as http;

class CountryPhoneCode {
  String? name;
  String? dialCode;
  String? isoCode;
  String? flag;

  CountryPhoneCode(
    this.name,
    this.dialCode,
    this.isoCode,
    this.flag,
  );

  factory CountryPhoneCode.fromJson(Map<String, dynamic> json) =>
      CountryPhoneCode(
        json['name'],
        json['dialCode'],
        json['isoCode'],
        "https://countryflagsapi.com/png/${json['isoCode']}",
      );

  // Methods
  static Future<List<CountryPhoneCode>> getAllPhoneCodes() async {
    List<CountryPhoneCode> countryPhoneCodes = [];
    try {
      final response = await http.get(
        Uri.parse(
            'https://gist.githubusercontent.com/kcak11/4a2f22fb8422342b3b3daa7a1965f4e4/raw/3d54c1a6869e2bf35f729881ef85af3f22c74fad/countries.json'),
      );
      if (response.statusCode == 200) {
        countryPhoneCodes = (jsonDecode(response.body) as List)
            .map((e) => CountryPhoneCode.fromJson(e))
            .toList();

        return countryPhoneCodes;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
