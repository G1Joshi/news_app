import 'package:get/get.dart';
import 'package:news_app/config/sharedprefs.dart';

class CountryController extends GetxController {
  final countrySet = false.obs;

  @override
  void onInit() {
    super.onInit();
    getStatus();
  }

  void getStatus() {
    if (Preferences.getCountryCode().isNotEmpty) {
      countrySet(true);
    }
  }
}
