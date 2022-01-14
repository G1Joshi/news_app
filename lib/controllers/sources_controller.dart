import 'package:get/get.dart';
import 'package:news_app/config/enums.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/services/source_api.dart';

class SourcesController extends GetxController {
  late SourcesAPI api = SourcesAPI();
  late Sources sources;

  final sourcesStatus = SourcesStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    getSources();
  }

  Future getSources() async {
    sources = await api.getSources();
    sourcesStatus(SourcesStatus.loaded);
  }
}
