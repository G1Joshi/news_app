import 'package:get/get.dart';

import 'data/network/network_requester.dart';
import 'data/repository/news_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkRequester(), permanent: true);
    Get.put(NewsRepository(), permanent: true);
  }
}
