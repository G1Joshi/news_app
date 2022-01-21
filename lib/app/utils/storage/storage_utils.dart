import 'package:get_storage/get_storage.dart';

class Storage {
  Storage._();

  static final _box = GetStorage();

  static void erase() => _box.erase();

  static void setCountry(String country) =>
      _box.write(StorageKeys.COUNTRY, country);

  static String getCountry() => _box.read(StorageKeys.COUNTRY) ?? "";

  static bool isCountryExists() => _box.read(StorageKeys.COUNTRY) != null;

  static void setCountryCode(String countryCode) =>
      _box.write(StorageKeys.COUNTRY_CODE, countryCode);

  static String getCountryCode() => _box.read(StorageKeys.COUNTRY_CODE) ?? "";

  static bool isCountryCodeExists() =>
      _box.read(StorageKeys.COUNTRY_CODE) != null;
}

class StorageKeys {
  StorageKeys._();

  static const APP_CONFIG = 'app_config';
  static const COUNTRY = 'country';
  static const COUNTRY_CODE = 'country_code';
}
