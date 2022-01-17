import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/config/enums.dart';
import 'package:news_app/config/sharedprefs.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/services/news_api.dart';

class NewsController extends GetxController {
  static TextEditingController queryController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late NewsAPI api = NewsAPI();
  late News news;
  Timer? debouncer;

  List<Source> selectedSources = [];
  static String sources = "";
  static String? category;
  static int page = 1;
  final newsStatus = NewsStatus.loading.obs;
  final countryName = Preferences.getCountry().obs;
  final pagination = false.obs;
  final searching = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(paginations);
    getTopNews();
  }

  void paginations() async {
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) &&
        (page < 10)) {
      pagination(true);
      page++;
      news.articles += await getNews();
      pagination(false);
    }
  }

  void debounce(callback, {duration = const Duration(milliseconds: 500)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future<List<Article>> getNews() async {
    try {
      final data = await api.getNews();
      return data.articles;
    } catch (e) {
      newsStatus(NewsStatus.error);
    }
    return [];
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

  Future getQueryNews() async {
    newsStatus(NewsStatus.loading);
    debounce(() async {
      try {
        news = await api.getQueryNews();
        news.totalResults == 0
            ? newsStatus(NewsStatus.empty)
            : newsStatus(NewsStatus.loaded);
      } catch (e) {
        newsStatus(NewsStatus.error);
      }
    });
  }

  Future getSourceNews() async {
    newsStatus(NewsStatus.loading);
    try {
      news = await api.getSourceNews();
      news.totalResults == 0
          ? newsStatus(NewsStatus.empty)
          : newsStatus(NewsStatus.loaded);
    } catch (e) {
      newsStatus(NewsStatus.error);
    }
  }

  Future getCategoryNews() async {
    newsStatus(NewsStatus.loading);
    try {
      news = await api.getCategoryNews();
      news.totalResults == 0
          ? newsStatus(NewsStatus.empty)
          : newsStatus(NewsStatus.loaded);
    } catch (e) {
      newsStatus(NewsStatus.error);
    }
  }
}
