import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/storage/storage_utils.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _startOnboarding();
  }

  _startOnboarding() async {
    if (Storage.isCountryCodeExists()) {
      Get.offAllNamed(Routes.HOME_PAGE);
    } else {
      Get.offAllNamed(Routes.LANDING);
    }
  }
}
