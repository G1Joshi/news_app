import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../base/base_controller.dart';
import '../../../data/models/article_model.dart';
import '../../../data/models/country_model.dart';
import '../../../data/models/dto/response.dart';
import '../../../data/models/news_model.dart';
import '../../../data/models/source_model.dart';
import '../../../data/repository/news_repository.dart';
import '../../../data/values/enums.dart';
import '../../../utils/storage/storage_utils.dart';

class HomePageController extends BaseController<NewsRepository> {
  static TextEditingController queryController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Timer? debouncer;

  late NewsRepository newsapi = NewsRepository();
  late News news;
  late Sources sources;

  List<Source> selectedSources = [];
  static String source = "";
  static String? category;
  static int page = 1;
  final newsStatus = NewsStatus.loading.obs;
  final countryName = Storage.getCountry().obs;
  final pagination = false.obs;
  final searching = false.obs;
  final sourcesStatus = SourcesStatus.loading.obs;

  @override
  void onInit() {
    scrollController.addListener(paginations);
    super.onInit();
  }

  @override
  void onReady() {
    getTopNews();
    getSources();
    super.onReady();
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

  void setCountry(int index) {
    Storage.setCountry(Country.countries[index].name);
    Storage.setCountryCode(Country.countries[index].code);
    countryName(Country.countries[index].name);
  }

  void resetFilter() {
    page = 1;
    category = null;
    source = "";
    selectedSources = [];
  }

  Future<List<Article>> getNews() async {
    try {
      RepoResponse<News> response = await repository.getNews();
      return response.data!.articles;
    } catch (e) {
      newsStatus(NewsStatus.error);
    }
    return [];
  }

  Future getTopNews() async {
    newsStatus(NewsStatus.loading);
    try {
      RepoResponse<News> response = await repository.getTopNews();
      news = response.data!;
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
        RepoResponse<News> response = await repository.getQueryNews();
        news = response.data!;
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
      RepoResponse<News> response = await repository.getSourceNews();
      news = response.data!;
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
      RepoResponse<News> response = await repository.getCategoryNews();
      news = response.data!;
      news.totalResults == 0
          ? newsStatus(NewsStatus.empty)
          : newsStatus(NewsStatus.loaded);
    } catch (e) {
      newsStatus(NewsStatus.error);
    }
  }

  Future getSources() async {
    sourcesStatus(SourcesStatus.loading);
    RepoResponse<Sources> response = await repository.getSources();
    sources = response.data!;
    sourcesStatus(SourcesStatus.loaded);
  }
}
