import 'package:get/get.dart';

import '../controllers/news_details_controller.dart';

class NewsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailsController>(
      () => NewsDetailsController(),
    );
  }
}
