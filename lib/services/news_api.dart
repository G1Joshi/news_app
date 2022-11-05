import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'package:news_app/models/news_model.dart';
import 'package:news_app/utils/secrets.dart';
import 'package:news_app/utils/storage.dart';

class NewsAPI {
  Future<News> getTopNews() async {
    late Response response;
    try {
      response = await get(
        Uri.parse(
            "${API.baseUrl}/top-headlines?country=${Storage.getCountryCode()}"),
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

  Future<News> getCategoryNews(String category) async {
    late Response response;
    try {
      response = await get(
        Uri.parse(
            "${API.baseUrl}/top-headlines?country=${Storage.getCountryCode()}&category=$category"),
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
            "${API.baseUrl}/top-headlines?country=${Storage.getCountryCode()}&q=$query"),
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
        Uri.parse("${API.baseUrl}/top-headlines?sources=$source"),
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
