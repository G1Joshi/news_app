import 'package:get/get.dart';

import '../data/network/network_requester.dart';

class BaseRepositry {
  NetworkRequester get controller => GetInstance().find<NetworkRequester>();
}
