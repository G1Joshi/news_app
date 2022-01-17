import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:news_app/config/secrets.dart';
import 'package:news_app/config/sharedprefs.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/models/news_model.dart';

class NewsAPI {
  bool queryEmpty() {
    return NewsController.queryController.text.isEmpty;
  }

  bool sourcesEmpty() {
    return NewsController.sources.isEmpty;
  }

  bool categoryEmpty() {
    return NewsController.category == null;
  }

  Future<News> getNews() async {
    late Response response;
    late String url;
    if (!queryEmpty() && !sourcesEmpty()) {
      url =
          "${API.baseUrl}/top-headlines?sources=${NewsController.sources}&q=${NewsController.queryController.text}&pageSize=10&page=${NewsController.page}";
    } else if (!queryEmpty() && !categoryEmpty()) {
      url =
          "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&category=${NewsController.category}&q=${NewsController.queryController.text}&pageSize=10&page=${NewsController.page}";
    } else if (!queryEmpty()) {
      url =
          "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&q=${NewsController.queryController.text}&pageSize=10&page=${NewsController.page}";
    } else if (!sourcesEmpty()) {
      url =
          "${API.baseUrl}/top-headlines?sources=${NewsController.sources}&pageSize=10&page=${NewsController.page}";
    } else if (!categoryEmpty()) {
      url =
          "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&category=${NewsController.category}&pageSize=10&page=${NewsController.page}";
    } else {
      url =
          "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&pageSize=10&page=${NewsController.page}";
    }
    try {
      response = await get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: API.key},
      );
    } catch (e) {
      throw Exception('Null');
    }
    if (response.statusCode == 200) {
      final body = News.fromJson(jsonDecode(response.body));
      if (body.status == 'ok') {
        return body;
      } else {
        throw Exception('Empty');
      }
    } else {
      throw Exception('Error');
    }
  }

  Future<News> getTopNews() async {
    late Response response;
    try {
      response = await get(
        Uri.parse(queryEmpty()
            ? "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}"
            : "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&q=${NewsController.queryController.text}"),
        headers: {HttpHeaders.authorizationHeader: API.key},
      );
    } catch (e) {
      throw Exception('Null');
    }
    if (response.statusCode == 200) {
      final body = News.fromJson(jsonDecode(response.body));
      if (body.status == 'ok') {
        return body;
      } else {
        throw Exception('Empty');
      }
    } else {
      throw Exception('Error');
    }
  }

  Future<News> getQueryNews() async {
    late Response response;
    try {
      response = await get(
        Uri.parse(
            "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&q=${NewsController.queryController.text}"),
        headers: {HttpHeaders.authorizationHeader: API.key},
      );
    } catch (e) {
      throw Exception('Null');
    }
    if (response.statusCode == 200) {
      final body = News.fromJson(jsonDecode(response.body));
      if (body.status == 'ok') {
        return body;
      } else {
        throw Exception('Empty');
      }
    } else {
      throw Exception('Error');
    }
  }

  Future<News> getSourceNews() async {
    late Response response;
    try {
      response = await get(
        Uri.parse(queryEmpty()
            ? "${API.baseUrl}/top-headlines?sources=${NewsController.sources}"
            : "${API.baseUrl}/top-headlines?sources=${NewsController.sources}&q=${NewsController.queryController.text}"),
        headers: {HttpHeaders.authorizationHeader: API.key},
      );
    } catch (e) {
      throw Exception('Null');
    }
    if (response.statusCode == 200) {
      final body = News.fromJson(jsonDecode(response.body));
      if (body.status == 'ok') {
        return body;
      } else {
        throw Exception('Empty');
      }
    } else {
      throw Exception('Error');
    }
  }

  Future<News> getCategoryNews() async {
    late Response response;
    try {
      response = await get(
        Uri.parse(queryEmpty()
            ? "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&category=${NewsController.category}"
            : "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&category=${NewsController.category}&q=${NewsController.queryController.text}"),
        headers: {HttpHeaders.authorizationHeader: API.key},
      );
    } catch (e) {
      throw Exception('Null');
    }
    if (response.statusCode == 200) {
      final body = News.fromJson(jsonDecode(response.body));
      if (body.status == 'ok') {
        return body;
      } else {
        throw Exception('Empty');
      }
    } else {
      throw Exception('Error');
    }
  }
}
