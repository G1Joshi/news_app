import 'package:get/get.dart';

import '../../../data/models/country_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/storage/storage_utils.dart';

class LandingController extends GetxController {
  void setCountry(int index) {
    Storage.setCountry(Country.countries[index].name);
    Storage.setCountryCode(Country.countries[index].code);
    Get.offAllNamed(Routes.HOME_PAGE);
  }
}
