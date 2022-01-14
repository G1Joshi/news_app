import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:news_app/config/secrets.dart';
import 'package:news_app/config/sharedprefs.dart';
import 'package:news_app/models/news_model.dart';

class NewsAPI {
  Future<News> getTopNews() async {
    late Response response;
    try {
      response = await get(
        Uri.parse(
            "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}"),
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

  Future<News> getSortedNews() async {
    late Response response;
    try {
      response = await get(
        Uri.parse(
            "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&sortBy=${Preferences.getSortBy()}"),
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

  Future<News> getQueryNews(String query) async {
    late Response response;
    try {
      response = await get(
        Uri.parse(
            "${API.baseUrl}/top-headlines?country=${Preferences.getCountryCode()}&q=$query&sortBy=${Preferences.getSortBy()}"),
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

  Future<News> getSourceNews(String source) async {
    late Response response;
    try {
      response = await get(
        Uri.parse(
            "${API.baseUrl}/top-headlines?sources=$source&sortBy=${Preferences.getSortBy()}"),
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
