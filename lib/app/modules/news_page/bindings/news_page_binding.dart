import 'package:get/get.dart';

import '../controllers/news_page_controller.dart';

class NewsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsPageController>(
      () => NewsPageController(),
    );
  }
}
