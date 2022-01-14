import 'package:get/get.dart';
import 'package:news_app/config/enums.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';

class NewsController extends GetxController {
  late NewsAPI api = NewsAPI();
  late News news;

  final newsStatus = NewsStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    getTopNews();
  }

  Future getTopNews() async {
    newsStatus(NewsStatus.loading);
    try {
      news = await api.getTopNews();
      news.totalResults == 0
          ? newsStatus(NewsStatus.empty)
          : newsStatus(NewsStatus.loaded);
    } catch (e) {
      newsStatus(NewsStatus.error);
    }
  }

  Future getSortedNews() async {
    newsStatus(NewsStatus.loading);
    try {
      news = await api.getSortedNews();
      news.totalResults == 0
          ? newsStatus(NewsStatus.empty)
          : newsStatus(NewsStatus.loaded);
    } catch (e) {
      newsStatus(NewsStatus.error);
    }
  }

  Future getQueryNews(String query) async {
    newsStatus(NewsStatus.loading);
    try {
      news = await api.getQueryNews(query);
      news.totalResults == 0
          ? newsStatus(NewsStatus.empty)
          : newsStatus(NewsStatus.loaded);
    } catch (e) {
      newsStatus(NewsStatus.error);
    }
  }

  Future getSourceNews(String source) async {
    newsStatus(NewsStatus.loading);
    try {
      news = await api.getSourceNews(source);
      news.totalResults == 0
          ? newsStatus(NewsStatus.empty)
          : newsStatus(NewsStatus.loaded);
    } catch (e) {
      newsStatus(NewsStatus.error);
    }
  }
}
