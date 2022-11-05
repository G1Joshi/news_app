import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: constant_identifier_names

class Storage {
  Storage._();

  static const String COUNTRY = "country";
  static const String COUNTRYCODE = "countryCode";

  static late SharedPreferences preference;

  static Future init() async {
    preference = await SharedPreferences.getInstance();
  }

  static Future setCountry(String country) async {
    await preference.setString(COUNTRY, country);
  }

  static String getCountry() {
    return preference.getString(COUNTRY) ?? "";
  }

  static Future setCountryCode(String countryCode) async {
    await preference.setString(COUNTRYCODE, countryCode);
  }

  static String getCountryCode() {
    return preference.getString(COUNTRYCODE) ?? "";
  }
}
